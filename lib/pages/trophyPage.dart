import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
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
              indicatorWeight: 4,

              tabs: [
                Tab(child: Text("Son Haberler",style: GoogleFonts.righteous(color: Colors.limeAccent),),),
                Tab(child: Text("Sıralama",style: GoogleFonts.righteous(color: Colors.limeAccent)),),
              ],
            ),
          ),
        ),
        body: BlocProvider(
          create: (context)=>DataBaseBloc(),
          child: TabBarView(
            children: [
              NewestPost(),
              WinnerPage(),
            ],

          ),
        ),
      ),
    );
  }
}
