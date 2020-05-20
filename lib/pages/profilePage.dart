import 'package:animations/animations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_event.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_state.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/pages/profileEditPage.dart';
import 'package:mucbirsebepler/pages/splashScreen.dart';
import 'package:mucbirsebepler/widgets/profileHelper.dart';
import 'package:mucbirsebepler/widgets/randomGradient.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';

class ProfilePage extends StatefulWidget {
  final User gelenUser;
  final User tiklayanUser;

  const ProfilePage({Key key, this.gelenUser,this.tiklayanUser}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataBaseBloc _dataBaseBloc;
  AuthBloc _authBloc;
  PostBloc _postBloc;
  ScrollController _fScrollController;
  ScrollController _sScrollController;
  bool kendiMi=true;


  @override
  void initState() {
    if(widget.tiklayanUser!=null&&widget.tiklayanUser!=widget.gelenUser){
      setState(() {
        kendiMi=false;
      });
    }
    _fScrollController = ScrollController();
    _sScrollController = ScrollController();
    _dataBaseBloc = BlocProvider.of<DataBaseBloc>(context);
    _postBloc = BlocProvider.of<PostBloc>(context);
    _authBloc=BlocProvider.of<AuthBloc>(context);
    _postBloc.add(GetUserPopulars(widget.gelenUser.userID));
    _dataBaseBloc.add(GetUserr(userID: widget.gelenUser.userID));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: _fScrollController,
        padding: EdgeInsets.all(0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              height: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              BlocListener(
                bloc: _authBloc,
                listener: (context, state) {
                  if(state is AuthLoadedState){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SplashScreen()),(Route<dynamic> route) => false);
                  }
                },
                child: BlocBuilder(
                  bloc: _dataBaseBloc,
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is DataBaseLoadingState ||
                        state is InitialDataBaseState) {
                      return Center(
                        child: LoadingBouncingGrid.square(
                          borderColor: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple,
                        ),
                      );
                    } else if (state is DataBaseErrorState) {
                      final snackBar = SnackBar(
                        content:
                            Text("Tospik internetinde bi sıkıntı var galiba"),
                        backgroundColor: Colors.red,
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else if (state is DataBaseLoadedState) {
                      User gelenUser = state.user;
                      LinearGradient linearGradient=randomGradient();
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          kendiMi?SafeArea(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FlatButton(
                                child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.exit_to_app,
                                      size: 30,
                                      color: Colors.limeAccent,
                                    )),
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.SCALE,
                                    dialogType: DialogType.INFO,
                                    body: Center(child: Text(
                                      'Hesaptan çıkmak üzeresin tospik?'
                                          'Bizi unutmayacaaz...',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),),
                                    btnOkOnPress: () {_authBloc.add(SignOut());},
                                  ).show();


                                },
                              ),
                            ),
                          ):SizedBox(width: 0,height: 0,),
                          kendiMi?SizedBox(width: 0,height: 0,):SafeArea(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: FlatButton(
                                child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                      color: Colors.limeAccent,
                                    )),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: profilePicturew(
                                    gelenUser, context),
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              GradientText(
                                gelenUser.liked.toString()+
                                " Kere Beğenildi",
                                gradient: randomGradient(),
                                style: GoogleFonts.righteous(fontSize: 20,fontWeight: FontWeight.bold),

                              ),
                              SizedBox(width: 6,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: kendiMi?RaisedButton(
                                    color: Colors.lime,
                                    highlightColor: Colors.deepPurpleAccent,
                                    elevation: 15,
                                    onPressed: () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BlocProvider(
                                                  create: (context)=>DataBaseBloc(),
                                                  child: ProfileEditPage(
                                                    editingUser: gelenUser,
                                                  ),
                                                )));
                                      });
                                    },
                                    child: Text("Profili düzenle"),
                                    shape: RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.limeAccent,width: 4.0)
                                    ),
                                  ):SizedBox(width: 0,height: 0,),
                                ),
                              ),

                            ],
                          ),
                          Center(
                            child: Text(
                              gelenUser.userName,
                              style: GoogleFonts.righteous(
                                  fontSize: 25,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Container(
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount:
                                      getBadgeNumbers(gelenUser.roller).length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 3.2,
                                          mainAxisSpacing: 4,
                                          crossAxisSpacing: 5,
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    List<String> roller =
                                        getBadgeNumbers(gelenUser.roller);
                                    return badgeMaker(
                                        index, gelenUser, roller[index]);
                                  }),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Popüler İddiaları",
                                      style: GoogleFonts.righteous(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 25),
                                    ),
                                    OpenContainer(
                                      closedBuilder:(BuildContext buildContext,VoidCallback voidCallback){
                                        return GestureDetector(
                                          onTap: voidCallback,
                                            child: CircleAvatar(child: Icon(Icons.arrow_forward),));
                                      },
                                      closedColor: Colors.transparent,
                                      openColor: Colors.transparent,
                                      transitionType: ContainerTransitionType.fade,
                                      transitionDuration: Duration(milliseconds: 800),
                                      openBuilder:(BuildContext buildContext,VoidCallback voidCallback){
                                        return Container(
                                          color: Colors.redAccent,
                                          child: SingleChildScrollView(
                                            controller: _sScrollController,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  SafeArea(
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: FlatButton(
                                                        child: CircleAvatar(
                                                            radius: 25,
                                                            backgroundColor: Colors.black,
                                                            child: Icon(
                                                              Icons.arrow_back,
                                                              size: 30,
                                                              color: Colors.limeAccent,
                                                            )),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  BlocBuilder(
                                                    bloc: _postBloc,
                                                    // ignore: missing_return
                                                    builder: (context, state) {

                                                      if (state is PostLoadingState) {
                                                        return Center(
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      } else if (state is PostErrorState) {
                                                        var snackbar = SnackBar(
                                                          content: Text(
                                                              "Bir hata oluştu tospik. Tekrar dener misin ?"),
                                                          backgroundColor: Colors.red,
                                                        );
                                                        Scaffold.of(context).showSnackBar(snackbar);
                                                      } else if (state is PostLoadedState) {
                                                        List<Post> listPost = state.listPost;
                                                        if (listPost.length != 0) {
                                                          return AnimationLimiter(
                                                            child: ListView.builder(
                                                                padding: EdgeInsets.all(0),
                                                                itemCount: listPost.length,
                                                                shrinkWrap: true,
                                                                itemBuilder: (contex, index) {
                                                                  return AnimationConfiguration
                                                                      .staggeredList(
                                                                      position: index,
                                                                      duration: const Duration(
                                                                          milliseconds: 875),
                                                                      child: ScaleAnimation(
                                                                        child: FadeInAnimation(
                                                                          child: postCoontainer(
                                                                            linearGradient: linearGradient,
                                                                              gelenUser:
                                                                              gelenUser,
                                                                              bloc: _postBloc,
                                                                              post: listPost[index],
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: MediaQuery.of(context).size.height,
                                                                              context: context),
                                                                        ),
                                                                      ));
                                                                }),
                                                          );
                                                        } else
                                                          return Container(
                                                            color: Colors.black,
                                                            child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(16.0),
                                                                  child: Text(
                                                                    "Henüz paylaştığın bi iddian yok tospik.",
                                                                    style: GoogleFonts.righteous(
                                                                        color: Colors.redAccent,
                                                                        fontSize: 25),
                                                                  ),
                                                                )),
                                                          );
                                                      } else
                                                        return Center(
                                                          child: CircularProgressIndicator(),
                                                        );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        );
                                      } ,


                                    )

                                  ],
                                ),
                              )),
                          lineDivider(),

                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> getBadgeNumbers(Map gelenMap) {
  List<String> rolleri = [];
  for (var i in gelenMap.entries) {
    if (i.value) {
      rolleri.add(i.key);
    }
  }
  return rolleri;
}
