import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Post {
  final int id;
  final String title;

  Post({
    required this.id,
    required this.title,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
    );
  }
}

class CacheService {
  static const String dataKey = 'cached_posts';
  static const String timeKey = 'cached_time';

  // Cache valid for 5 minutes
  static const int cacheDuration = 5 * 60 * 1000;

  Future<void> saveCache(String data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(dataKey, data);

    await prefs.setInt(
      timeKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<String?> getValidCache() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString(dataKey);
    final int? savedTime = prefs.getInt(timeKey);

    if (data == null || savedTime == null) {
      return null;
    }

    final int currentTime =
        DateTime.now().millisecondsSinceEpoch;

    final int difference = currentTime - savedTime;

    if (difference < cacheDuration) {
      return data;
    }

    return null;
  }
}

class ApiService {
  Future<String> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/posts',
      ),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class Repository {
  final CacheService cacheService = CacheService();
  final ApiService apiService = ApiService();

  Future<List<Post>> getPosts() async {
    // First check cache
    final cachedData = await cacheService.getValidCache();

    if (cachedData != null) {
      print("Data loaded from cache");

      return parsePosts(cachedData);
    }

    // Cache expired or not available
    print("Cache expired. Fetching fresh data...");

    final freshData = await apiService.fetchData();

    // Save fresh data with current timestamp
    await cacheService.saveCache(freshData);

    return parsePosts(freshData);
  }

  List<Post> parsePosts(String jsonString) {
    final List<dynamic> data = jsonDecode(jsonString);

    return data
        .map(
          (item) => Post.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Repository repository = Repository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cache Expiry',
      home: CacheScreen(repository: repository),
    );
  }
}

class CacheScreen extends StatefulWidget {
  final Repository repository;

  const CacheScreen({
    super.key,
    required this.repository,
  });

  @override
  State<CacheScreen> createState() => _CacheScreenState();
}

class _CacheScreenState extends State<CacheScreen> {
  List<Post> posts = [];

  bool isLoading = false;

  String message = '';

  Future<void> loadPosts() async {
    setState(() {
      isLoading = true;
      message = 'Loading...';
    });

    try {
      final result = await widget.repository.getPosts();

      setState(() {
        posts = result;
        message = 'Data loaded successfully';
      });
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5-Minute Cache'),
        actions: [
          IconButton(
            onPressed: loadPosts,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),

          if (isLoading)
            const CircularProgressIndicator(),

          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${post.id}'),
                    ),
                    title: Text(post.title),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}