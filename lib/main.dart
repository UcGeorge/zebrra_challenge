import 'package:flutter/material.dart';
import 'package:zebrra_challenge/data/models/article.dart';
import 'package:zebrra_challenge/data/repositories/news/news.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Zebrra Challenge',
      home: MyHomePage(title: 'Zebrra Challenge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article>? articles;
  bool loading = false;

  void _getNews() async {
    setState(() {
      loading = true;
    });
    await NewsRepository.getEverything(
      'NO_TOKEN',
      q: 'Tesla',
      from: DateTime(2020, 8, 30),
      sortBy: 'publishedAt',
      onError: (errorMessage) => showDialog(
        context: context,
        builder: (context) => Container(
          color: const Color(0xffFAFAFA),
          padding: const EdgeInsets.all(24),
          child: Text(errorMessage),
        ),
      ),
    ).then((value) {
      if (mounted) {
        setState(() {
          articles = value;
        });
      } else {
        articles = value;
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: articles?.length ?? 0,
              itemBuilder: (context, i) => ListTile(
                title: Text(articles![i].title),
                subtitle: Text(
                  'By ${articles![i].author}',
                  overflow: TextOverflow.ellipsis,
                ),
                isThreeLine: true,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getNews,
        tooltip: 'Get news',
        child: const Icon(Icons.search),
      ),
    );
  }
}
