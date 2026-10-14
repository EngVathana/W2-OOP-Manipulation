
class BankAccount {
  final int _accountId;
  final String _accountOwner;
  double _balance = 0;

  BankAccount(this._accountId, this._accountOwner);

  int get accountId => _accountId;
  String get accountOwner => _accountOwner;
  double get balance => _balance;

  void credit(double amount) {
    if (amount <= 0) {
      throw Exception('Amount must be positive!');
    }

    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= 0) {
      throw Exception('Amount must be positive!');
    }

    if (amount > _balance) {
      throw Exception('Insufficient balance for withdrawal!');
    }

    _balance -= amount;
  }
}

class Bank {
  final String name;
  final List<BankAccount> _accounts = [];

  Bank({required this.name});

  List<BankAccount> get accounts =>
      List.unmodifiable(_accounts);

  BankAccount createAccount(
    int accountId,
    String accountOwner,
  ) {
    for (var account in _accounts) {
      if (account.accountId == accountId) {
        throw Exception(
          'Account with ID $accountId already exists!',
        );
      }
    }

    BankAccount newAccount = BankAccount(
      accountId,
      accountOwner,
    );

    _accounts.add(newAccount);
    return newAccount;
  }
}

void main() {
  Bank myBank = Bank(name: 'CADT Bank');

  BankAccount ronanAccount =
      myBank.createAccount(100, 'Ronan');

  print('Balance: \$${ronanAccount.balance}');

  ronanAccount.credit(100);
  print('Balance: \$${ronanAccount.balance}');

  ronanAccount.withdraw(50);
  print('Balance: \$${ronanAccount.balance}');

  try {
    ronanAccount.withdraw(75);
  } catch (e) {
    print(e);
  }

  try {
    myBank.createAccount(100, 'Honlgy');
  } catch (e) {
    print(e);
  }
}

