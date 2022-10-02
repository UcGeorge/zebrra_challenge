import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final WebViewArgs args;
  const WebViewContainer({Key? key, required this.args}) : super(key: key);

  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final _key = UniqueKey();
  int progress = 0;
  bool finishedLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: widget.args.title != null
            ? Text(
                widget.args.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 21 / 20,
                ),
              )
            : null,
        bottom: PreferredSize(
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            !finishedLoading ? 2 : 0,
          ),
          child: !finishedLoading
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 2,
                    width: MediaQuery.of(context).size.width * (progress / 100),
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: WebView(
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.args.url,
              onProgress: (p) {
                setState(() {
                  progress = p;
                });
              },
              onPageFinished: (p) {
                setState(() {
                  finishedLoading = true;
                });
              },
              onPageStarted: (p) {
                setState(() {
                  finishedLoading = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WebViewArgs {
  final String url;
  final String? title;

  WebViewArgs(this.url, [this.title]);
}
