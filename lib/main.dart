import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/search.dart';
import './tabs.dart';
import './detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewsNxt',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        // fontFamily: 'PlayfairDisplay',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map data;
  List userData;

  Future myfunc() async {
    var response = await http.get(
        'https://newsapi.org/v2/everything?domains=thehindu.com&apiKey=59fbc34b71d74ccfae74a441c7644288');
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NewsNxt',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.cyan],
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'TOP NEWS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: 220,
              child: ListView.builder(
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
                        title: Text(
                          '${userData[index]['title']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${userData[index]['description']}'),
                      ),
                    ),
                  );
                },
              ),
            ),
            Tabs(),
          ],
        ),
      ),
    );
  }
}
