import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_event.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/pages/homePage.dart';
import 'package:mucbirsebepler/pages/signUpPage.dart';
import 'package:mucbirsebepler/widgets/bezierContainer.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  String butonText = "Giriş Yap";
  String textfieldText = "Şifre";
  String sifreniUnuttun = "Şifrenizi mi unuttunuz ?";
  bool isReset = true;
  double oppacity = 1.0;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  Widget _entryField(String title,
      {bool isPassword = false, double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.limeAccent,
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
                keyboardType: isPassword
                    ? TextInputType.text
                    : TextInputType.emailAddress,
                decoration: InputDecoration(
                    suffixIcon: isPassword
                        ? FaIcon(FontAwesomeIcons.key)
                        : FaIcon(FontAwesomeIcons.at),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      ),
    );
  }

  Widget _submitButton(AuthBloc authBloc) {
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
                colors: [Colors.lime,Colors.limeAccent])),
        child: Text(
          butonText,
          style: GoogleFonts.righteous(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () async {
        if (isReset) {
          authBloc.add(EmailLogin(
              email: _emailController.text,
              password: _passwordController.text));
        } else {
          authBloc.add(ForgetPass(email: _emailController.text));
        }
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
            'Hesabın yok mu ?',
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(providers: [
                            BlocProvider<AuthBloc>(
                              create: (context) => AuthBloc(),
                            ),
                            BlocProvider<DataBaseBloc>(
                              create: (context) => DataBaseBloc(),
                            )
                          ], child: SignUpPage())));
            },
            child: Text(
              'Kaydol',
              style: TextStyle(
                  color: Colors.limeAccent,
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
        _entryField("Email", opacity: 1.0),
        _entryField(textfieldText, isPassword: true, opacity: oppacity),
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
      resizeToAvoidBottomInset: false,
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
          if (state is AuthLoadingState || state is ForgetLoadingState) {
            widget = LoadingBouncingGrid.square(
              borderColor: Colors.deepOrangeAccent,
              backgroundColor: Colors.deepOrangeAccent,
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
          if (state is ForgetLoadedState) {
            widget = SizedBox(
              width: 0,
              height: 0,
            );
            showDialog(
                context: context,
                builder: (_) => FlareGiffyDialog(
                      onlyOkButton: true,
                      flarePath: 'assets/dialog.flr',
                      flareAnimation: 'jump',
                      title: Text(
                        'Şifre Sıfırlama Maili Gönderildi',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      description: Text(
                        "Şifre sıfırlama linki mail hesabınıza gönderildi",
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                      entryAnimation: EntryAnimation.TOP_RIGHT,
                      onOkButtonPressed: () {
                        Navigator.of(context).pop();
                      },
                    ));
          }
          if (state is ForgetErrorState) {
            widget = SizedBox(
              width: 0,
              height: 0,
            );
            final snackBar = SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder(
          bloc: _authBloc,
          builder: (context, statee) {
            return SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: -MediaQuery.of(context).size.height * .23,
                          right: -MediaQuery.of(context).size.width * .4,
                          child: BezierContainer(
                            kayitMi: false,
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
                            _submitButton(_authBloc),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isReset) {
                                      textfieldText =
                                          "Tekrar Emailiniz Giriniz";
                                      butonText = "Şifreyi Sıfırla";
                                      sifreniUnuttun = "Vazgeç";
                                      oppacity = 0.0;
                                      isReset = false;
                                    } else {
                                      textfieldText = "Şifre";
                                      butonText = "Giriş Yap";
                                      sifreniUnuttun =
                                          "Şifrenizi mi unuttunuz?";
                                      oppacity = 1.0;
                                      isReset = true;
                                    }
                                  });
                                },
                                child: Container(
                                  child: Text(sifreniUnuttun,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.deepPurpleAccent,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            divider(),
                            facebookButton(_authBloc),
                            Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      Center(child: widget),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _createAccountLabel(),
                      ),
                      Positioned(top: 40, left: 0, child: backButton(context)),

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
