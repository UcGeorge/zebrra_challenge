import 'package:flutter/material.dart';
import 'package:zebrra_challenge/logic/util/navigation.dart';
import 'package:zebrra_challenge/view/pages/news_page.dart';

import '../../../data/models/article.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      onTap: () => cupertinoPageNav(
        context,
        child: NewsPage(article: article),
      ),
      subtitle: Text(
        '${article.author} - ${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
