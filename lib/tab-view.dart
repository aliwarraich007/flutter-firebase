import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('tab view'),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text('Home'),
                  ),
                  Tab(
                    child: Text('About'),
                  )
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Center(
                  child: Text('This is tab view 1'),
                ),
                Center(
                  child: Text('This is tab view 2'),
                )
              ],
            ),
          )),
    );
  }
}
