import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/student_controller.dart';
import 'state/student_states.dart';
import 'view/empty_state_view.dart';
import 'view/error_state_view.dart';
import 'view/loading_view.dart';
import 'view/student_list_item.dart';

/// Main screen for the student info demo
class StudentInfoScreen extends StatefulWidget {
  /// Constructor
  const StudentInfoScreen({super.key});

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  late StudentController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StudentController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Information'),
        ),
        body: Consumer<StudentController>(
          builder: (context, controller, child) {
            final state = controller.currentState;

            // Show different views based on the current state
            if (state is LoadingState) {
              return const LoadingView();
            }

            if (state is ErrorState) {
              // Show error view
              return ErrorStateView(errorMessage: state.errorMessage);
            }

            if (state is LoadedState && controller.students != null) {
              // Show the student list
              return ListView.builder(
                itemCount: controller.students!.length,
                itemBuilder: (context, index) {
                  return StudentListItem(
                    student: controller.students![index],
                    index: index,
                  );
                },
              );
            }

            // Initial state or no students
            return const EmptyStateView();
          },
        ),
        floatingActionButton: Consumer<StudentController>(
          builder: (context, controller, child) {
            return FloatingActionButton.extended(
              onPressed: controller.isLoading
                  ? null // Disable the button when loading
                  : () => controller.fetchStudents(),
              label: const Text('Get Student Info'),
              icon: const Icon(Icons.refresh),
              backgroundColor: controller.isLoading ? Colors.grey : Colors.blue,
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
