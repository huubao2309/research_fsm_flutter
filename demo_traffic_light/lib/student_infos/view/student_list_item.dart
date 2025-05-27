import 'package:flutter/material.dart';

import '../model/student.dart';

/// Widget to display a single student in the list
class StudentListItem extends StatelessWidget {
  /// The student to display
  final Student student;
  
  /// The index in the list (for displaying the order number)
  final int index;

  /// Constructor
  const StudentListItem({
    super.key,
    required this.student,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text('${index + 1}'),
        ),
        title: Text(student.name),
        subtitle: Text('Age: ${student.age}'),
        trailing: Text(student.phoneNumber),
      ),
    );
  }
}
