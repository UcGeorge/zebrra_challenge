import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'data/models/article.dart';
import 'data/repositories/news/news.dart';

final _log = Logger('main.dart');

//* INFO, WARNING, FATAL, Exception

void main() async {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    // final logFileName =
    //     'logs/${record.time.hour}-${record.time.minute}-${record.time.day}-${record.time.month}-${record.time.year}.log';
    final logString = '${record.level.name.padRight(7)} : ${record.time} : '
        '${record.loggerName} : '
        '${record.message}';
    debugPrint(logString);
    // File(logFileName).writeAsStringSync(logString, mode: FileMode.append);
  });
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
  String? error;
  bool loading = false;

  void _getNews() async {
    setState(() {
      loading = true;
      error = null;
    });
    await NewsRepository.getEverything(
      'NO_TOKEN',
      q: 'Tesla',
      from: DateTime(2022, 8, 30),
      sortBy: 'publishedAt',
      onError: (errorMessage) {
        if (mounted) {
          setState(() {
            error = errorMessage;
          });
        } else {
          error = errorMessage;
        }
      },
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
          : error != null
              ? Center(
                  child: Text(error!),
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
