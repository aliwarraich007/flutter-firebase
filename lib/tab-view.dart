import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
