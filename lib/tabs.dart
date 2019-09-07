import 'package:flutter/material.dart';
import 'bnews.dart';
import 'tnews.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.cyan],
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.attach_money),
                  text: 'BUSINESS',
                ),
                Tab(
                  icon: Icon(Icons.devices),
                  text: 'TECH',
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: SizedBox(
                height: 245,
                child: TabBarView(
                  children: <Widget>[
                    BNews(),
                    TNews(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
