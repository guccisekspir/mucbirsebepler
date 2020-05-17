import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/widgets/profileHelper.dart';

class ProfileEditPage extends StatefulWidget {
  final User editingUser;

  const ProfileEditPage({Key key, this.editingUser}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController _userNameController;
  DataBaseBloc _dataBaseBloc;
  File _profilFoto;


  @override
  void initState() {
    // TODO: implement initState
    _userNameController=TextEditingController(text:"");
    _dataBaseBloc= BlocProvider.of<DataBaseBloc>(context);
    super.initState();
  }

  _kameradanFotoCek()async{
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }
  _galeridenFotoCek()async{
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });

  }
  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.limeAccent,
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    )),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Center(
              child: _profilFoto!=null?profilePicturew(widget.editingUser, context,gelenFoto: _profilFoto):profilePicturew(
                  widget.editingUser, context)),
          Center(child: GestureDetector(
            onTap: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.limeAccent,
                      height: 160,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.camera,color: Colors.black,),
                            title: Text("Kameradan Çek",style: GoogleFonts.righteous(),),
                            onTap: () {
                              _kameradanFotoCek();
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.image,color: Colors.black,),
                            title: Text("Galeriden Seç",style: GoogleFonts.righteous(),),
                            onTap: () {
                              _galeridenFotoCek();
                            },
                          ),
                        ],
                      ),
                    );
                  });


            },
            child: Padding(
              padding: const EdgeInsets.only(left: 120),
              child: CircleAvatar(
                backgroundColor: Colors.limeAccent,
                child: Icon(Icons.add_a_photo,color: Colors.black,),
              ),
            ),
          ),),
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              maxLength: 15,
              cursorColor: Colors.limeAccent,
              style: GoogleFonts.righteous(color: Colors.limeAccent),
              decoration: InputDecoration(
                errorStyle: GoogleFonts.righteous(color: Colors.redAccent),
                labelStyle: GoogleFonts.righteous(color: Colors.limeAccent),
                counterStyle: GoogleFonts.righteous(color: Colors.limeAccent),
                fillColor: Colors.limeAccent,
                focusColor: Colors.limeAccent,
                hoverColor: Colors.limeAccent,
                labelText: "Yeni Kullanıcı Adı",
                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.limeAccent)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.limeAccent)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.limeAccent)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.limeAccent)
                )
              ),
              controller: _userNameController,
            ),
          ),
          SizedBox(width: 30,),
          Center(child: RaisedButton(
            child: Text("username değiştir"),
            onPressed: (){


              _dataBaseBloc.add(ChangeProfile(userID: widget.editingUser.userID,newPP: _profilFoto,newUserName: _userNameController.text));
            },

          ),)
        ],
      ),
    );
  }
}
