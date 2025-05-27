import 'dart:async';
import 'dart:math';

import '../model/api_response.dart';
import '../model/student.dart';

/// Repository for fetching student data
class StudentRepository {
  /// List of all possible students
  final List<Student> _allStudents = [];
  
  /// Number of API calls made
  int _apiCallCount = 0;
  
  /// Random number generator
  final Random _random = Random();
  
  /// Constructor that initializes the student data
  StudentRepository() {
    _initializeStudentData();
  }
  
  /// Initialize the student data with 50 fake students
  void _initializeStudentData() {
    final List<String> firstNames = [
      'John', 'Jane', 'Michael', 'Emily', 'David', 'Sarah', 'James', 'Emma',
      'Robert', 'Olivia', 'William', 'Sophia', 'Joseph', 'Ava', 'Thomas', 'Isabella',
      'Charles', 'Mia', 'Daniel', 'Charlotte', 'Matthew', 'Amelia', 'Anthony', 'Harper',
      'Mark', 'Evelyn', 'Donald', 'Abigail', 'Steven', 'Emily', 'Paul', 'Elizabeth',
      'Andrew', 'Sofia', 'Joshua', 'Avery', 'Kenneth', 'Ella', 'Kevin', 'Scarlett',
      'Brian', 'Grace', 'George', 'Chloe', 'Edward', 'Victoria', 'Ronald', 'Riley',
      'Timothy', 'Aria', 'Jason', 'Lily', 'Jeffrey', 'Hannah', 'Ryan', 'Layla',
      'Jacob', 'Zoe', 'Gary', 'Nora', 'Nicholas', 'Lily', 'Eric', 'Eleanor',
      'Jonathan', 'Hazel', 'Stephen', 'Violet', 'Larry', 'Aurora', 'Justin', 'Savannah',
      'Scott', 'Audrey', 'Brandon', 'Brooklyn', 'Benjamin', 'Bella', 'Samuel', 'Claire'
    ];
    
    final List<String> lastNames = [
      'Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Davis', 'Miller', 'Wilson',
      'Moore', 'Taylor', 'Anderson', 'Thomas', 'Jackson', 'White', 'Harris', 'Martin',
      'Thompson', 'Garcia', 'Martinez', 'Robinson', 'Clark', 'Rodriguez', 'Lewis', 'Lee',
      'Walker', 'Hall', 'Allen', 'Young', 'Hernandez', 'King', 'Wright', 'Lopez',
      'Hill', 'Scott', 'Green', 'Adams', 'Baker', 'Gonzalez', 'Nelson', 'Carter',
      'Mitchell', 'Perez', 'Roberts', 'Turner', 'Phillips', 'Campbell', 'Parker', 'Evans',
      'Edwards', 'Collins', 'Stewart', 'Sanchez', 'Morris', 'Rogers', 'Reed', 'Cook',
      'Morgan', 'Bell', 'Murphy', 'Bailey', 'Rivera', 'Cooper', 'Richardson', 'Cox',
      'Howard', 'Ward', 'Torres', 'Peterson', 'Gray', 'Ramirez', 'James', 'Watson',
      'Brooks', 'Kelly', 'Sanders', 'Price', 'Bennett', 'Wood', 'Barnes', 'Ross'
    ];
    
    // Generate 50 unique students
    for (int i = 0; i < 50; i++) {
      final String firstName = firstNames[_random.nextInt(firstNames.length)];
      final String lastName = lastNames[_random.nextInt(lastNames.length)];
      final String name = '$firstName $lastName';
      final int age = 18 + _random.nextInt(10); // Ages between 18 and 27
      
      // Generate a random phone number
      final String phoneNumber = '0${9 + _random.nextInt(2)}${List.generate(8, (_) => _random.nextInt(10)).join()}';
      
      _allStudents.add(Student(
        id: i + 1,
        name: name,
        age: age,
        phoneNumber: phoneNumber,
      ));
    }
  }
  
  /// Get a list of students
  /// 
  /// Simulates an API call that returns 10 random students
  /// On the third call, it will return an error
  Future<ApiResponse<List<Student>>> getStudents() async {
    // Increment the API call count
    _apiCallCount++;
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // On the third call, return an error
    if (_apiCallCount == 3) {
      return ApiResponse.error(400, 'Failed to fetch students');
    }
    
    // Shuffle the list and take 10 random students
    final List<Student> shuffledStudents = List.from(_allStudents)..shuffle(_random);
    final List<Student> randomStudents = shuffledStudents.take(8).toList();
    
    return ApiResponse.success(randomStudents);
  }
  
  /// Reset the API call count (for testing purposes)
  void resetApiCallCount() {
    _apiCallCount = 0;
  }
}
