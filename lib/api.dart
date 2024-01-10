import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHttpExample(),
    );
  }
}

class MyHttpExample extends StatefulWidget {
  const MyHttpExample({super.key});

  @override
  _MyHttpExampleState createState() => _MyHttpExampleState();
}

class _MyHttpExampleState extends State<MyHttpExample> {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts/1";

  Future<Map<String, dynamic>> fetchData(String method) async {
    http.Response response;
    switch (method) {
      case "GET":
        response = await http.get(Uri.parse(apiUrl));
        break;
      case "POST":
        response = await http.post(
          Uri.parse(apiUrl),
          body:
              json.encode({"title": "New Post", "body": "This is a new post"}),
          headers: {"Content-Type": "application/json"},
        );
        break;
      case "DELETE":
        response = await http.delete(Uri.parse(apiUrl));
        break;
      case "PATCH":
        response = await http.patch(
          Uri.parse(apiUrl),
          body: json.encode({"title": "Updated Post"}),
          headers: {"Content-Type": "application/json"},
        );
        break;
    }

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Methods Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = await fetchData("GET");
                print(data);
              },
              child: const Text('GET'),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = await fetchData("POST");
                print(data);
              },
              child: const Text('POST'),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = await fetchData("DELETE");
                print(data);
              },
              child: const Text('DELETE'),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> data = await fetchData("PATCH");
                print(data);
              },
              child: const Text('PATCH'),
            ),
          ],
        ),
      ),
    );
  }
}
