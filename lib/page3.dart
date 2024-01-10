import 'package:flutter/material.dart';
import 'package:labs/page4.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});
  @override
  State<Page3> createState() {
    return _Page3();
  }
}

class _Page3 extends State<Page3> {
  @override
  Widget build(context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Menu'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'home'),
                Tab(
                  text: 'about',
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Page4(),
              Text('hwlloe 2'),
            ],
          ),
        ),
      ),
    );
  }
}
