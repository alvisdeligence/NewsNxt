import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './detail.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchInput = TextEditingController();
  var searchTitle = '';

  void submitData() {
    if (searchInput.text.isEmpty) {
      return;
    }
    final enteredData = searchInput.text.toLowerCase();
    setState(() {
      searchTitle = enteredData;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    searchInput.clear();

    setState(() {
      myfunc();
    });
  }

  Map data;
  List userData;

  Future myfunc() async {
    var response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=in&category=$searchTitle&apiKey=59fbc34b71d74ccfae74a441c7644288');
    data = json.decode(response.body);

    setState(() {
      userData = data['articles'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'NewsNxt',
        style: TextStyle(fontStyle: FontStyle.italic),
      )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search by Categories eg. Business, Sports'),
                  controller: searchInput,
                  onSubmitted: (_) => submitData(),
                ),
              ),
              Container(
                child: RaisedButton(
                  color: Colors.blue[100],
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: submitData,
                ),
              ),
              Container(
                  child: searchTitle == ''
                      ? Container(
                          padding: EdgeInsets.all(50),
                          child: Text(
                            'Nothing to Show!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.red, Colors.cyan],
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                '${searchTitle.toUpperCase()} NEWS',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 400,
                              child: ListView.builder(
                                itemCount:
                                    userData == null ? 0 : userData.length,
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
                                                author: userData[index]
                                                    ['author'],
                                                content: userData[index]
                                                    ['content'],
                                                img: userData[index]
                                                    ['urlToImage'],
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(
                                          '${userData[index]['title']}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            '${userData[index]['description']}'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
