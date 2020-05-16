import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';

class ProfileEditPage extends StatefulWidget {
  final User editingUser;

  const ProfileEditPage({Key key, this.editingUser}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController _userNameController;
  DataBaseBloc _dataBaseBloc;

  @override
  void initState() {
    // TODO: implement initState
    _userNameController=TextEditingController(text: "");
    _dataBaseBloc= BlocProvider.of<DataBaseBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(width: 30,),
          Center(child: SafeArea(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Eben",
                prefixText: "yenen",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.limeAccent)
                )
              ),
              controller: _userNameController,
            ),
          ),),
          SizedBox(width: 30,),
          Center(child: RaisedButton(
            child: Text("username değiştir"),
            onPressed: (){
              _dataBaseBloc.add(ChangeUsername(userID: widget.editingUser.userID,newUsername: _userNameController.text));
            },

          ),)
        ],
      ),
    );
  }
}
