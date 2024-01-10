import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labs/page3.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});
  @override
  State<Page2> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<Page2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> login() async {
    BuildContext currentContext = context;
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } catch (e) {
      Navigator.push(
          currentContext, MaterialPageRoute(builder: (context) => const Page3()));
      print(e);
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: email,
            decoration: const InputDecoration(labelText: 'email'),
          ),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(labelText: 'password'),
          ),
          ElevatedButton(onPressed: login, child: const Text('Login')),
        ],
      ),
    ));
  }
}
