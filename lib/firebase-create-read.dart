import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:labs/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase CRUD operations'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.all(10.0),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final name = controller.text;
                      _insertData(name: name);
                    },
                    child: const Text('Create'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      final name = controller.text;
                      _updateData(name: name);
                    },
                    child: const Text('Update'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      _deleteData();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('employees')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    var documents = snapshot.data!.docs;
                    List<Widget> dataWidget = [];
                    for (var doc in documents) {
                      var data = doc.data() as Map<String, dynamic>;
                      dataWidget.add(ListTile(
                        title: const Text('Name'),
                        subtitle: Text(data['name']),
                      ));
                    }
                    return ListView(
                      children: dataWidget,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData({required String name}) async {
    await FirebaseFirestore.instance
        .collection('employees')
        .add({'name': name});
    controller.clear();
  }

  Future<void> _updateData({required String name}) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();
    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(docId)
          .update({'name': name});
      controller.clear();
    }
  }

  Future<void> _deleteData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();
    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(docId)
          .delete();
    }
  }
}
