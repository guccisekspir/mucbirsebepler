import 'package:flutter/material.dart';
import 'package:mucbirsebepler/model/user.dart';


class ProfilePage extends StatefulWidget {
  final User gelenUser;

  const ProfilePage({Key key, this.gelenUser}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.gelenUser.userName),),
    );
  }
}
