import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zebrra_challenge/logic/util/navigation.dart';
import 'package:zebrra_challenge/view/pages/web_view.dart';

import '../../data/models/article.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Share.share(
                '${article.title}\n\n${article.description}\n\n${article.url}'),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.share),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => cupertinoPageNav(
              context,
              child: WebViewContainer(
                args: WebViewArgs(article.url, article.source.name),
              ),
            ),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.open_in_browser_rounded),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null) Image.network(article.urlToImage!),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'By ${article.author} • ${article.source.name}\n${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.5,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.description,
                maxLines: 100,
                // style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(article.content),
            ),
          ],
        ),
      ),
    );
  }
}
