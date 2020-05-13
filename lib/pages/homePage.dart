import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/bloc/navBarBloc.dart';
import 'package:mucbirsebepler/pages/discoverPage.dart';
import 'package:mucbirsebepler/pages/profilePage.dart';
import 'package:mucbirsebepler/pages/shopPage.dart';
import 'package:mucbirsebepler/pages/postPage.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  final User _user;
  DataBaseBloc _databaseBloc;
  BottomNavBarBloc _bottomNavBarBloc;

  _HomePageState(this._user);
  @override
  void initState() {

    _databaseBloc = BlocProvider.of<DataBaseBloc>(context);
    _databaseBloc.add(SaveUserDB(user: _user));
    _bottomNavBarBloc = BottomNavBarBloc();
    super.initState();
  }
  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _curvedKey = GlobalKey();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (context)=>PostBloc(),),
        BlocProvider<DataBaseBloc>(create: (context)=>DataBaseBloc(),)

      ],
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: StreamBuilder(   //bloc yapımızı seçimlerden haberdar etmek
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context,AsyncSnapshot<NavBarItem> snapshot){
            switch(snapshot.data){
              case NavBarItem.PROFILE:
                return ProfilePage(gelenUser: _user,);
              case NavBarItem.SHOP:
                return ShopPage();
              case NavBarItem.TICK:
                return BlocProvider(
                    create: (context)=>PostBloc(),
                    child: PostPage(user: _user,));
              case NavBarItem.HOME:
                return DiscoverPage(user: _user,);
            }

          },
        ),
        bottomNavigationBar: SafeArea( //BottomNavBar'ı telefon ui'ı engellememesi için
          child: StreamBuilder(  //blocdaki streami dinlemek
              stream: _bottomNavBarBloc.itemStream,
              initialData: _bottomNavBarBloc.defaultItem,
              builder: (context, snapshot) {
                return CurvedNavigationBar(
                  key: _curvedKey,
                  index: 0,
                  height: 50.0,
                  items: <Widget>[
                    Icon(LineAwesomeIcons.home,color: Theme.of(context).primaryColor, size: 30),
                    Icon(LineAwesomeIcons.newspaper_o,color: Theme.of(context).primaryColor, size: 30),
                    Icon(LineAwesomeIcons.cart_arrow_down,color: Theme.of(context).primaryColor, size: 30),
                    Icon(LineAwesomeIcons.user,color: Theme.of(context).primaryColor, size: 30),
                  ],
                  buttonBackgroundColor: Theme.of(context).accentColor,
                  color: Theme.of(context).accentColor,
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: (index){
                    _bottomNavBarBloc.pickItem(index);
                  },
                );
              }
          ),
        ),
      ),
    );
  }
}
