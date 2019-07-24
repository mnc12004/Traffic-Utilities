import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BreathResults extends StatefulWidget {
  static const String id = 'breath_results';

  final txtLD;
  final txtOcc;
  final txtTT;
  final txtRes;

  const BreathResults(
      {Key key, this.txtLD, this.txtOcc, this.txtTT, this.txtRes})
      : super(key: key);

  @override
  _BreathResultsState createState() => _BreathResultsState();
}

class _BreathResultsState extends State<BreathResults> {
  bool showSpinner = false;
  var newUrl;
  @override
  Widget build(BuildContext context) {
    if (widget.txtLD == null) {
      newUrl =
          'https://webbreath.azurewebsites.net/calc.asp?txtOcc=${widget.txtOcc}&txtTT=${widget.txtTT}&txtRes=${widget.txtRes}';
    } else {
      newUrl =
          'https://webbreath.azurewebsites.net/calc.asp?txtLD=${widget.txtLD}&txtOcc=${widget.txtOcc}&txtTT=${widget.txtTT}&txtRes=${widget.txtRes}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Breath Test Results'),
        centerTitle: true,
      ),
      body: WebviewScaffold(
        url: newUrl,
      ),
    );
  }
}
