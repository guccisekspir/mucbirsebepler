import 'package:flutter/material.dart';
import 'package:mucbirsebepler/pages/tabBarPages/newestPost.dart';
import 'package:mucbirsebepler/pages/tabBarPages/winnerPage.dart';


class TrophyPage extends StatefulWidget {
  @override
  _TrophyPageState createState() => _TrophyPageState();
}

class _TrophyPageState extends State<TrophyPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/14),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Keşfet",style: TextStyle(color: Colors.limeAccent),),),
                Tab(child: Text("Takiplerim",style: TextStyle(color: Colors.limeAccent)),),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            NewestPost(),
            WinnerPage(),
          ],

        ),
      ),
    );
  }
}
