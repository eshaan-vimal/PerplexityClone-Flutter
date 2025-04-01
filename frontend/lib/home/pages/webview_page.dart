import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewPage extends StatefulWidget
{
  final String uri;

  const WebviewPage ({
    super.key,
    required this.uri,
  });


  @override
  State<WebviewPage> createState() => _WebviewPageState();
}


class _WebviewPageState extends State<WebviewPage>
{
  late WebViewController _controller;

  @override
  void initState ()
  {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse(widget.uri));
  }

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}