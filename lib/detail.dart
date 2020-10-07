import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final String title;
  final String text;

  const Detail({Key key, this.title, this.text}): super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Card(
        child: ListTile(
          title: Text(widget.title),
          subtitle: Text(widget.text),
        ),
      ),
    );
  }
}
