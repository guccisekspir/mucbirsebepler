import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
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
  Widget waitingWidget = Container(
    color: Colors.transparent,
    height: 60,
    width: 60,
  );

  @override
  void initState() {
    // TODO: implement initState
    _userNameController = TextEditingController(text: "");
    _dataBaseBloc = BlocProvider.of<DataBaseBloc>(context);
    super.initState();
  }

  _kameradanFotoCek() async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  _galeridenFotoCek() async {
    var _yeniResim = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: BlocListener(
        bloc: _dataBaseBloc,
        listener: (context, state) {
          if (state is DataBaseLoadingState) {
            setState(() {
              waitingWidget = Container(
                width: 60,
                height: 60,
                child: LoadingBouncingGrid.square(
                  borderColor: Colors.limeAccent,
                  backgroundColor: Colors.limeAccent,
                ),
              );
            });
          }
          if (state is DataBaseLoadedState) {
            setState(() {
              waitingWidget = SizedBox(
                width: 60,
                height: 60,
              );
            });

            if (state.isChangedPP || state.isChangedUser) {
              showDialog(
                  //TODO bunu uihelpera ekle
                  context: context,
                  builder: (_) => FlareGiffyDialog(
                        onlyOkButton: true,
                        flarePath: 'assets/meditation.flr',
                        flareAnimation: 'idle',
                        title: Text(
                          '   Profil bilgilerin '
                          'güncellendi tospik',
                          style: GoogleFonts.righteous(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.limeAccent),
                        ),
                        entryAnimation: EntryAnimation.BOTTOM_RIGHT,
                        onOkButtonPressed: () {
                          Navigator.of(context).pop();
                        },
                      ));
            } else if (!state.isChangedUser) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content:
                    Text("Bu nick kullanılmakta lütfen farklı nick seçiniz"),
                backgroundColor: Colors.redAccent,
              ));
            } else if (!state.isChangedPP) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Profil fotoğrafınız yüklenirken 1 hata oluştu.Lütfen başka fotoğraf deneyiniz"),
                backgroundColor: Colors.redAccent,
              ));
            }
          }
          if (state is DataBaseErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("İnternet bağlantınızda sıkıntı var :-/"),
              backgroundColor: Colors.redAccent,
            ));
          }
        },
        child: Column(
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
                child: _profilFoto != null
                    ? profilePicturew(widget.editingUser, context,
                        gelenFoto: _profilFoto)
                    : profilePicturew(widget.editingUser, context)),
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.limeAccent,
                          height: 160,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.camera,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "Kameradan Çek",
                                  style: GoogleFonts.righteous(),
                                ),
                                onTap: () {
                                  _kameradanFotoCek();
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.image,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "Galeriden Seç",
                                  style: GoogleFonts.righteous(),
                                ),
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
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            waitingWidget,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                maxLength: 15,
                cursorColor: Colors.limeAccent,
                style: GoogleFonts.righteous(color: Colors.limeAccent),
                decoration: InputDecoration(
                    errorStyle: GoogleFonts.righteous(color: Colors.redAccent),
                    labelStyle: GoogleFonts.righteous(color: Colors.limeAccent),
                    counterStyle:
                        GoogleFonts.righteous(color: Colors.limeAccent),
                    fillColor: Colors.limeAccent,
                    focusColor: Colors.limeAccent,
                    hoverColor: Colors.limeAccent,
                    labelText: "Yeni Kullanıcı Adı",
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.limeAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.limeAccent)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.limeAccent)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.limeAccent))),
                controller: _userNameController,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Center(
              child: RaisedButton(
                child: Text("Değişiklikleri Kaydet",style: GoogleFonts.righteous(fontWeight: FontWeight.bold),),
                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.limeAccent,width: 4.0)
                ),
                color: Colors.lime,
                highlightColor: Colors.deepPurpleAccent,
                elevation: 15,
                onPressed: () {
                  if (_profilFoto == null && _userNameController.text == "") {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Herhangi bir şeyi değiştirmediniz !"),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    _dataBaseBloc.add(ChangeProfile(
                        userID: widget.editingUser.userID,
                        newPP: _profilFoto,
                        newUserName: _userNameController.text));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
