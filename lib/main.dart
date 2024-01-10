import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labs/page2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  navigateToPage() {
    // Use Navigator.push to navigate to a new screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Page2(),
      ),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: navigateToPage,
            child: const Text('Go to Second Screen'),
          ),
        ],
      ),
    ));
  }
}
