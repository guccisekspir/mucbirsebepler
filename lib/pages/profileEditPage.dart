import 'package:flutter/material.dart';
import 'package:mucbirsebepler/model/user.dart';

class ProfileEditPage extends StatefulWidget {
  final User editingUser;

  const ProfileEditPage({Key key, this.editingUser}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      child: Center(child: Text(widget.editingUser.userName),),

    );
  }
}
