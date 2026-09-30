import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Model
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}

// Local Data Source
abstract class LocalDataSource<T> {
  Future<List<T>> getItems();
  Future<void> saveItems(List<T> items);
}

// Remote Data Source
abstract class RemoteDataSource<T> {
  Future<List<T>> fetchItems();
}

// SharedPreferences Local Source
class SharedPrefsDataSource<T> implements LocalDataSource<T> {
  final String key;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  SharedPrefsDataSource({
    required this.key,
    required this.fromJson,
    required this.toJson,
  });

  @override
  Future<List<T>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);

    return decoded
        .map((item) => fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  @override
  Future<void> saveItems(List<T> items) async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(
      items.map((item) => toJson(item)).toList(),
    );

    await prefs.setString(key, data);
  }
}

// API Remote Source
class ApiDataSource<T> implements RemoteDataSource<T> {
  final String url;
  final T Function(Map<String, dynamic>) fromJson;

  ApiDataSource({
    required this.url,
    required this.fromJson,
  });

  @override
  Future<List<T>> fetchItems() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((item) => fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

// Generic Repository
class Repository<T> {
  final LocalDataSource<T> local;
  final RemoteDataSource<T> remote;

  Repository({
    required this.local,
    required this.remote,
  });

  Future<List<T>> getItems() async {
    try {
      final items = await remote.fetchItems();
      await local.saveItems(items);
      return items;
    } catch (e) {
      return await local.getItems();
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Repository<Post> repository = Repository<Post>(
    local: SharedPrefsDataSource<Post>(
      key: 'posts',
      fromJson: Post.fromJson,
      toJson: (post) => post.toJson(),
    ),
    remote: ApiDataSource<Post>(
      url: 'https://jsonplaceholder.typicode.com/posts',
      fromJson: Post.fromJson,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryScreen(repository: repository),
    );
  }
}

class RepositoryScreen extends StatefulWidget {
  final Repository<Post> repository;

  const RepositoryScreen({
    super.key,
    required this.repository,
  });

  @override
  State<RepositoryScreen> createState() => _RepositoryScreenState();
}

class _RepositoryScreenState extends State<RepositoryScreen> {
  List<Post> posts = [];
  bool isLoading = false;
  String message = '';

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final result = await widget.repository.getItems();

      setState(() {
        posts = result;
        message = result.isEmpty
            ? 'No data available'
            : 'Data loaded (${result.length} items)';
      });
    } catch (e) {
      setState(() {
        message = 'Unable to load data';
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
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generic Repository'),
        actions: [
          IconButton(
            onPressed: loadData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          if (isLoading)
            const CircularProgressIndicator(),
          Text(message),
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