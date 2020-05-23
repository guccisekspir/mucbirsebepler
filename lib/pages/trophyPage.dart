import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/post_bloc.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/pages/tabBarPages/newestPost.dart';
import 'package:mucbirsebepler/pages/tabBarPages/popularPost.dart';
import 'package:mucbirsebepler/pages/tabBarPages/weeklyPost.dart';
import 'package:mucbirsebepler/pages/tabBarPages/winnerPage.dart';

class TrophyPage extends StatefulWidget {
  final User user;

  const TrophyPage({Key key, this.user}) : super(key: key);

  @override
  _TrophyPageState createState() => _TrophyPageState();
}

class _TrophyPageState extends State<TrophyPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 14),
          child: AppBar(
            bottom: TabBar(
              indicatorWeight: 4,
              tabs: [
                Tab(
                  child: Text("Popüler Haberler",
                      style: GoogleFonts.righteous(color: Colors.limeAccent)),
                ),
                Tab(
                  child: Text("Haftanın Haberleri",
                      style: GoogleFonts.righteous(color: Colors.limeAccent)),
                ),
                Tab(

                  child: Text(
                    "Son Haberler",
                    style: GoogleFonts.righteous(color: Colors.limeAccent),
                  ),
                ),
                Tab(
                  child: Text("Sıralama",
                      style: GoogleFonts.righteous(color: Colors.limeAccent)),
                ),

              ],
            ),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<PostBloc>(
              create: (context) => PostBloc(),
            ),
            BlocProvider<DataBaseBloc>(
              create: (context) => DataBaseBloc(),
            ),
          ],
          child: TabBarView(
            children: [
              PopularPost(user: widget.user,),
              WeeklyPost(user: widget.user,),
              NewestPost(
                haftaMi: false,
                user: widget.user,
              ),
              WinnerPage(),
            ],
          ),
        ),
      ),
    );
  }
}
