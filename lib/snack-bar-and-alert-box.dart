import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentListScreen(),
    );
  }
}

class Student {
  final String name;
  final int age;

  Student(this.name, this.age);
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> students = [
    Student('Muhammad Ali', 22),
    Student('Ali', 22),
    // Add more student data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].name),
            subtitle: Text('Age: ${students[index].age}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement update functionality
                    showSnackBarMessage(
                        'Update student: ${students[index].name}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Show confirmation dialog before deletion
                    showDeleteConfirmationDialog(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure to delete ${students[index].name}?'),
          actions: [
            TextButton(
              onPressed: () {
                // User clicked Yes, delete data
                deleteStudent(index);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // User clicked No, close dialog
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
      showSnackBarMessage('Student deleted successfully');
    });
  }
}
