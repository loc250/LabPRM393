import 'dart:async';

Future<void> main() async {
  print('========================================');
  print('       LAB 2 - DART ESSENTIALS');
  print('========================================');

  exercise1();
  exercise2();
  exercise3();
  exercise4();

  await exercise5();

  print('\n========================================');
  print('           LAB COMPLETED');
  print('========================================');
}

// ============================================================
// EXERCISE 1 - BASIC SYNTAX & DATA TYPES
// ============================================================

void exercise1() {
  print('\n---------- EXERCISE 1 ----------');

  // Basic data types.
  int age = 20;
  double gpa = 3.5;
  String name = 'Loc';
  bool isStudent = true;

  print('Name: $name');
  print('Age: $age');
  print('GPA: $gpa');
  print('Is student: $isStudent');

  // String interpolation.
  print('$name is $age years old.');
  print('GPA after bonus: ${gpa + 0.2}');
}

// ============================================================
// EXERCISE 2 - COLLECTIONS & OPERATORS
// ============================================================

void exercise2() {
  print('\n---------- EXERCISE 2 ----------');

  // List.
  List<int> numbers = [10, 20, 30, 40, 50];

  print('Original list: $numbers');

  // Indexing.
  print('First number: ${numbers[0]}');

  // Arithmetic operators.
  int sum = numbers[0] + numbers[1];
  int difference = numbers[2] - numbers[0];

  print('10 + 20 = $sum');
  print('30 - 10 = $difference');

  // Comparison operator.
  print('Is 20 equal to 20? ${numbers[1] == 20}');

  // Logical operator.
  bool condition1 = numbers[0] > 5;
  bool condition2 = numbers[1] < 30;

  print('condition1 && condition2: ${condition1 && condition2}');

  // Ternary operator.
  String result =
      numbers.length > 3 ? 'More than 3 numbers' : '3 or fewer numbers';

  print('Result: $result');

  // add()
  numbers.add(60);
  print('After add(60): $numbers');

  // remove()
  numbers.remove(20);
  print('After remove(20): $numbers');

  // Set.
  Set<int> uniqueNumbers = {1, 2, 2, 3, 4, 4, 5};

  print('Set: $uniqueNumbers');

  uniqueNumbers.add(6);
  uniqueNumbers.remove(1);

  print('Set after changes: $uniqueNumbers');

  // Map.
  Map<String, dynamic> student = {
    'name': 'Loc',
    'age': 20,
    'major': 'Information Technology',
  };

  print('Student name: ${student['name']}');
  print('Student age: ${student['age']}');
  print('Student major: ${student['major']}');
}

// ============================================================
// EXERCISE 3 - CONTROL FLOW & FUNCTIONS
// ============================================================

void exercise3() {
  print('\n---------- EXERCISE 3 ----------');

  // if / else
  int score = 85;

  if (score >= 90) {
    print('Score: $score -> Excellent');
  } else if (score >= 70) {
    print('Score: $score -> Good');
  } else if (score >= 50) {
    print('Score: $score -> Pass');
  } else {
    print('Score: $score -> Fail');
  }

  // switch
  int day = 3;

  switch (day) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    case 4:
      print('Thursday');
      break;
    case 5:
      print('Friday');
      break;
    case 6:
      print('Saturday');
      break;
    case 7:
      print('Sunday');
      break;
    default:
      print('Invalid day');
  }

  // for loop
  print('For loop:');

  for (int i = 1; i <= 5; i++) {
    print(i);
  }

  // for-in loop
  List<String> fruits = ['Apple', 'Banana', 'Orange'];

  print('For-in loop:');

  for (String fruit in fruits) {
    print(fruit);
  }

  // forEach()
  print('forEach loop:');

  fruits.forEach((fruit) {
    print(fruit);
  });

  // Normal function
  int result1 = addNumbers(10, 20);

  print('Normal function: $result1');

  // Arrow function
  int result2 = multiplyNumbers(5, 4);

  print('Arrow function: $result2');
}

// Normal function.
int addNumbers(int a, int b) {
  return a + b;
}

// Arrow function.
int multiplyNumbers(int a, int b) => a * b;

// ============================================================
// EXERCISE 4 - INTRO TO OOP
// ============================================================

class Car {
  String brand;

  // Constructor.
  Car(this.brand);

  // Named constructor.
  Car.named(String brandName) : brand = brandName;

  // Method.
  void drive() {
    print('$brand is driving.');
  }
}

// Inheritance.
class ElectricCar extends Car {
  ElectricCar(String brand) : super(brand);

  // Method overriding.
  @override
  void drive() {
    print('$brand electric car is driving silently.');
  }
}

void exercise4() {
  print('\n---------- EXERCISE 4 ----------');

  // Object using normal constructor.
  Car car1 = Car('Toyota');

  print('Car 1 brand: ${car1.brand}');
  car1.drive();

  // Object using named constructor.
  Car car2 = Car.named('Honda');

  print('Car 2 brand: ${car2.brand}');
  car2.drive();

  // Object of subclass.
  ElectricCar electricCar = ElectricCar('Tesla');

  print('Electric car brand: ${electricCar.brand}');
  electricCar.drive();
}

// ============================================================
// EXERCISE 5 - ASYNC, FUTURE, NULL SAFETY & STREAMS
// ============================================================

Future<void> exercise5() async {
  print('\n---------- EXERCISE 5 ----------');

  // Future + async/await.
  print('Loading data...');

  String data = await loadData();

  print('Data loaded: $data');

  // Null safety.
  String? nullableName;

  // ?? operator.
  String displayName = nullableName ?? 'Guest';

  print('Name using ?? : $displayName');

  // Assign a value.
  nullableName = 'Loc';

  print('Name after assignment: $nullableName');

  // ! operator.
  print('Name using ! : ${nullableName!}');

  // Stream.
  print('Stream values:');

  Stream<int> numberStream =
      Stream.fromIterable([1, 2, 3, 4, 5]);

  await for (int number in numberStream) {
    print('Stream value: $number');
  }

  print('Stream completed.');
}

// Future.delayed() simulates loading data.
Future<String> loadData() async {
  await Future.delayed(Duration(seconds: 2));

  return 'Data loaded successfully';
}