import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String content;
  final String img;
  DetailPage({this.title, this.author, this.content, this.img});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'NewsNxt',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: img != null
                      ? Image.network(img)
                      : Text('IMAGE NOT FOUND'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: title != null
                      ? Text(
                          title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'TITLE NOT FOUND',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: author != null
                      ? Text(
                          author,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )
                      : Text(
                          'AUTHOR NOT FOUND',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: content != null
                      ? Text(
                          content,
                          style: TextStyle(fontSize: 18),
                        )
                      : Text(
                          'CONTENT NOT FOUND',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
