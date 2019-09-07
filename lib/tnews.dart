import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './detail.dart';

class TNews extends StatefulWidget {
  @override
  _TNewsState createState() => _TNewsState();
}

class _TNewsState extends State<TNews> {
  Map data;
  List userData;

  Future myfunc() async {
    var response = await http.get(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=59fbc34b71d74ccfae74a441c7644288');
    data = json.decode(response.body);

    setState(() {
      userData = data['articles'];
    });
  }

  @override
  void initState() {
    super.initState();
    myfunc();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userData == null ? 0 : userData.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      title: userData[index]['title'],
                      author: userData[index]['author'],
                      content: userData[index]['content'],
                      img: userData[index]['urlToImage'],
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userData[index]['urlToImage']),
                radius: 30,
              ),
              title: Text(
                '${userData[index]['title']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
