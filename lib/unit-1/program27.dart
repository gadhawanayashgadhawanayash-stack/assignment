class Account {
double balance;

Account(this.balance);
}

mixin InterestCalculator on Account {
void calculateInterest() {
double interest = balance * 5 / 100;

print("Account Balance: ₹$balance");
print("Interest at 5%: ₹$interest");
}
}

class SavingsAccount extends Account with InterestCalculator {
SavingsAccount(double balance) : super(balance);
}

void main() {
SavingsAccount account = SavingsAccount(10000);

account.calculateInterest();
}