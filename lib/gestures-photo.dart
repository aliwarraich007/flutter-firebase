import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Clickable Text using GestureDetector
            GestureDetector(
              onTap: () {
                print('Text Clicked!');
                // Perform any action when the text is clicked
              },
              child: const Text(
                'Click Me!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            // Zoomable Image using PhotoView
            SizedBox(
              width: 150,
              height: 150,
              child: PhotoView(
                imageProvider: const NetworkImage(
                  'https://variety.com/wp-content/uploads/2020/01/taylor-swift-variety-facetime.jpg?w=1000',
                ),
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ),
            const SizedBox(height: 20),
            // Clickable Image using InkWell
            InkWell(
              onTap: () {
                print('Another Image Clicked!');
                // Perform any action when the image is clicked
              },
              child: Image.network(
                'https://variety.com/wp-content/uploads/2020/01/taylor-swift-variety-facetime.jpg?w=1000',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
