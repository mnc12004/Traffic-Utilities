import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebRegoCheck extends StatefulWidget {
  final url;
  final title;

  const WebRegoCheck({Key key, this.url, this.title}) : super(key: key);

  @override
  _WebRegoCheckState createState() => _WebRegoCheckState();
}

class _WebRegoCheckState extends State<WebRegoCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/logo.png'),
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: WebviewScaffold(
          url: widget.url,
          geolocationEnabled: true,
          withLocalStorage: true,
          hidden: true,
          initialChild: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 150.0,
                  width: 150.0,
                ),
                Center(
                  child: TypewriterAnimatedTextKit(
                    text: [
                      'Loading...',
                      'Please Wait...',
                    ],
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
