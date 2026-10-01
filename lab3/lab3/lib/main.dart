import 'dart:async';
import 'dart:convert';

// ============================================================
// LAB 3 – ADVANCED DART PRACTICE EXERCISES
// ============================================================

void main() async {
  print('================================================');
  print('LAB 3 – ADVANCED DART PRACTICE EXERCISES');
  print('================================================');

  await exercise1();
  await exercise2();
  await exercise3();
  await exercise4();
  exercise5();

  print('\n================================================');
  print('ALL EXERCISES COMPLETED');
  print('================================================');
}

// ============================================================
// EXERCISE 1 – PRODUCT MODEL & REPOSITORY
// Future + Stream
// ============================================================

class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
  }
}

class ProductRepository {
  // Simulates loading products from a database/API.
  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Product(id: 1, name: 'Laptop', price: 1200.00),
      Product(id: 2, name: 'Mouse', price: 25.50),
      Product(id: 3, name: 'Keyboard', price: 45.00),
    ];
  }

  // Broadcast stream allows multiple listeners.
  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  // Simulates adding a new product in real time.
  void addProduct(Product product) {
    _controller.add(product);
  }

  void dispose() {
    _controller.close();
  }
}

Future<void> exercise1() async {
  print('\n================================================');
  print('EXERCISE 1 – PRODUCT MODEL & REPOSITORY');
  print('================================================');

  final repository = ProductRepository();

  // Get all existing products using Future.
  final products = await repository.getAll();

  print('\nProducts loaded using Future:');

  for (final product in products) {
    print(product);
  }

  // Listen for real-time product updates.
  final subscription = repository.liveAdded().listen((product) {
    print('\nNew product received through Stream:');
    print(product);
  });

  // Simulate a new product being added.
  repository.addProduct(
    Product(
      id: 4,
      name: 'Headphones',
      price: 80.00,
    ),
  );

  // Give the stream time to deliver the event.
  await Future.delayed(const Duration(milliseconds: 100));

  await subscription.cancel();
  repository.dispose();
}

// ============================================================
// EXERCISE 2 – USER REPOSITORY WITH JSON
// JSON + Future + fromJson
// ============================================================

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  // Converts JSON data into a User object.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email)';
  }
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    // Simulated JSON response from an API.
    const jsonData = '''
    [
      {
        "name": "Alice",
        "email": "alice@example.com"
      },
      {
        "name": "Bob",
        "email": "bob@example.com"
      },
      {
        "name": "Charlie",
        "email": "charlie@example.com"
      }
    ]
    ''';

    // Convert JSON string into Dart objects.
    final List<dynamic> decodedData = jsonDecode(jsonData);

    // Convert each JSON object into a User object.
    return decodedData
        .map((json) => User.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

Future<void> exercise2() async {
  print('\n================================================');
  print('EXERCISE 2 – USER REPOSITORY WITH JSON');
  print('================================================');

  final repository = UserRepository();

  final users = await repository.fetchUsers();

  print('\nUsers parsed from JSON:');

  for (final user in users) {
    print(user);
  }
}

// ============================================================
// EXERCISE 3 – ASYNC + MICROTASK DEBUGGING
// Microtask queue vs Event queue
// ============================================================

Future<void> exercise3() async {
  print('\n================================================');
  print('EXERCISE 3 – ASYNC + MICROTASK DEBUGGING');
  print('================================================');

  print('1. Start');

  // Microtasks have higher priority than normal event callbacks.
  scheduleMicrotask(() {
    print('3. Microtask executed');
  });

  // Future() schedules an event callback.
  Future(() {
    print('4. Future event executed');
  });

  print('2. End of synchronous code');

  // Wait so the asynchronous callbacks can finish.
  await Future.delayed(const Duration(milliseconds: 100));

  print(
    '\nExplanation: '
    'The synchronous code runs first. '
    'Then the microtask queue is processed before the event queue.',
  );
}

// ============================================================
// EXERCISE 4 – STREAM TRANSFORMATION
// map() + where()
// ============================================================

Future<void> exercise4() async {
  print('\n================================================');
  print('EXERCISE 4 – STREAM TRANSFORMATION');
  print('================================================');

  // Create a stream containing numbers 1 to 5.
  final numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  // map() squares every number.
  // where() keeps only even squares.
  final transformedStream = numberStream
      .map((number) => number * number)
      .where((square) => square % 2 == 0);

  print('\nEven square values:');

  await for (final value in transformedStream) {
    print(value);
  }
}

// ============================================================
// EXERCISE 5 – FACTORY CONSTRUCTOR & CACHE
// Singleton pattern
// ============================================================

class Settings {
  // Private static cached instance.
  static final Settings _instance = Settings._internal();

  // Private constructor.
  Settings._internal();

  // Factory constructor returns the same cached instance.
  factory Settings() {
    return _instance;
  }

  String language = 'English';
  bool darkMode = false;
}

void exercise5() {
  print('\n================================================');
  print('EXERCISE 5 – FACTORY CONSTRUCTOR & CACHE');
  print('================================================');

  final settingsA = Settings();
  final settingsB = Settings();

  print('settingsA.language = ${settingsA.language}');
  print('settingsB.language = ${settingsB.language}');

  // Both variables refer to the same object.
  print('identical(settingsA, settingsB): '
      '${identical(settingsA, settingsB)}');

  print('\nSingleton confirmed: both objects are the same instance.');
}