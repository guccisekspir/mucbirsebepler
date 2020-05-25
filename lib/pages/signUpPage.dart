import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_event.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/pages/homePage.dart';

import 'package:mucbirsebepler/widgets/bezierContainer.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool isIos=false;

  @override
  void initState() {
    if(Platform.isIOS){
      isIos=true;
    }
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: isPassword ? _passwordController : _emailController,
              obscureText: isPassword,
              cursorColor: Colors.deepOrange,
              keyboardType:
                  isPassword ? TextInputType.text : TextInputType.emailAddress,
              decoration: InputDecoration(
                  suffixIcon: isPassword
                      ? FaIcon(FontAwesomeIcons.key)
                      : FaIcon(FontAwesomeIcons.at),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Color(0xfff3f3f4),
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton(AuthBloc authBloc, AuthState state) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.deepPurpleAccent.shade400,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  spreadRadius: 0.3)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black, Colors.black87])),
        child: Text(
          'Kaydol',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        authBloc.add(EmailSign(
            email: _emailController.text, password: _passwordController.text));
      },
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hesabın var mı ?',
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Giriş Yap',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Mücbir ',
          style: GoogleFonts.pressStart2p(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.deepPurpleAccent,
          ),
          children: [
            TextSpan(
              text: 'Sebepler',
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        _entryField("Şifre", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);
    Widget widget = SizedBox(
      width: 0,
      height: 0,
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthErrorState) {
            widget = SizedBox(
              width: 0,
              height: 0,
            );
            final snackBar = SnackBar(
              content: Text("Kullanıcı adı/şifre hatalı"),
              backgroundColor: Colors.red,
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
          if (state is AuthLoadingState) {
            widget = LoadingBouncingGrid.square(
              borderColor: Colors.deepPurpleAccent,
              backgroundColor: Colors.deepPurpleAccent,
            );
          }
          if (state is AuthLoadedState) {
            widget = SizedBox(
              width: 0,
              height: 0,
            );
            if (state.user != null) {
              sharedKaydet(state.user.userID);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => DataBaseBloc(),
                          child: HomePage(
                            user: state.user,
                          ))),
                  (Route<dynamic> route) => false);
            }
          }
        },
        child: BlocBuilder(
          bloc: _authBloc,
          builder: (context, statee) {
            return SingleChildScrollView(
                child: Container(
              color: Colors.limeAccent,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .18,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer(
                        kayitMi: true,
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        _title(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 80,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(_authBloc, statee),
                        divider(),
                        isIos?SizedBox(width: 0,height: 0,):facebookButton(_authBloc),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: widget,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _createAccountLabel(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: backButton(context),
                  ),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }

  Future<void> sharedKaydet(String userID) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", userID);
  }
}
