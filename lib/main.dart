import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'view/pages/home_page.dart';
import 'view/theme.dart';

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
    return MaterialApp(
      title: 'Zebrra Challenge',
      themeMode: ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'News'),
    );
  }
}
