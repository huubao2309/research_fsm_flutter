/// Model class representing a student
class Student {
  /// Unique identifier for the student
  final int id;
  
  /// Student's full name
  final String name;
  
  /// Student's age
  final int age;
  
  /// Student's phone number
  final String phoneNumber;

  /// Constructor
  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
  });

  /// Create a Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  /// Convert Student to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age, phoneNumber: $phoneNumber}';
  }
}
