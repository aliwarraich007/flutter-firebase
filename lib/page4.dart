import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: Page4(),
  ));
}

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<Page4> {
  late Future<List<Article>> _news;

  @override
  void initState() {
    super.initState();
    _news = getTopHeadlines();
  }

  Future<List<Article>> getTopHeadlines() async {
    const String apiKey = '935ff55d23ea4b9ba02c1825aaeb4423';
    const String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us';

    try {
      final response = await http.get(Uri.parse('$baseUrl&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List<dynamic> articles = data['articles'];
          return articles.map((article) => Article.fromJson(article)).toList();
        } else {
          print('Failed to load news. Status: ${data['status']}');
          return [];
        }
      } else {
        print('Failed to load news. Status Code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'News'),
              Tab(text: 'News Length'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsTab(news: _news),
            NewsLengthTab(news: _news),
          ],
        ),
      ),
    );
  }
}

class NewsTab extends StatelessWidget {
  final Future<List<Article>> news;

  const NewsTab({required this.news});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: news,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No news available.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final article = snapshot.data![index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.description),
              );
            },
          );
        }
      },
    );
  }
}

class NewsLengthTab extends StatelessWidget {
  final Future<List<Article>> news;

  const NewsLengthTab({required this.news});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Article>>(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final newsLength = snapshot.data!.length;
            return Text('Total News Length: $newsLength');
          }
        },
      ),
    );
  }
}

class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}
