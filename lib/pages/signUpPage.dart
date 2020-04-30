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

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _emailController;
  TextEditingController _passwordController;
  AuthBloc _authBloc;
  DataBaseBloc _dbBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: isPassword ? _passwordController : _emailController,
              obscureText: isPassword,
              cursorColor: Colors.deepOrange,
              keyboardType: isPassword ? TextInputType.text : TextInputType
                  .emailAddress,
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
        width: MediaQuery
            .of(context)
            .size
            .width,
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


        //TODO koyulan verileri gönder

      },
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.deepPurpleAccent,
                thickness: 1,
              ),
            ),
          ),
          Text('ya da', style: TextStyle(color: Colors.deepPurpleAccent),),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.deepPurpleAccent,
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton(AuthBloc bloc) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('G',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                bloc.add(GoogleSign());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Google ile Kaydol',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ],
      ),
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
            style: TextStyle(color: Colors.deepPurpleAccent,
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
          style: GoogleFonts.portLligatSans(
            textStyle: Theme
                .of(context)
                .textTheme
                .display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'Sebepler',
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 30),
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
    final _dbBloc=BlocProvider.of<DataBaseBloc>(context);
    Widget widget=SizedBox(width: 0,height: 0,);
    return Scaffold(
      body: BlocListener(
        bloc: _authBloc,
        listener: (context, state) {
          if(state is AuthErrorState){
            widget=SizedBox(width: 0,height: 0,);
            final snackBar= SnackBar(
              content: Text("Kullanıcı adı/şifre hatalı"),
              backgroundColor: Colors.red,

            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
          if(state is AuthLoadingState){
            widget =LoadingBouncingGrid.square(borderColor: Colors.deepPurpleAccent,backgroundColor: Colors.deepPurpleAccent,);
          }
          if(state is AuthLoadedState){
            widget=SizedBox(width: 0,height: 0,);
            if(state.user!=null){
              _dbBloc.add(SaveUserDB(user: state.user));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(user: state.user,)));
            }

          }
        },
        child: BlocBuilder(
          bloc: _authBloc,
          builder: (context, statee) {
            return SingleChildScrollView(
                child: Container(
                  color: Color(0xfffbb448),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: SizedBox(),
                            ),
                            _title(),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 80,
                            ),
                            _emailPasswordWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            _submitButton(_authBloc, statee),
                            _divider(),
                            _facebookButton(_authBloc),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      Center(child: widget,),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _createAccountLabel(),
                      ),
                      Positioned(top: 40, left: 0, child: _backButton()),
                      Positioned(
                          top: -MediaQuery
                              .of(context)
                              .size
                              .height * .18,
                          right: -MediaQuery
                              .of(context)
                              .size
                              .width * .4,
                          child: BezierContainer(kayitMi: true,))
                    ],
                  ),
                )
            );
          },
        ),
      ),
    );
  }
}