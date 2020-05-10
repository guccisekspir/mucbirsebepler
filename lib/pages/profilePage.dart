import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/pages/postPage.dart';
import 'package:mucbirsebepler/pages/profileEditPage.dart';
import 'package:mucbirsebepler/widgets/profileHelper.dart';
import 'package:mucbirsebepler/widgets/randomGradient.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';

class ProfilePage extends StatefulWidget {
  final User gelenUser;

  const ProfilePage({Key key, this.gelenUser}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataBaseBloc _dataBaseBloc;
  PostBloc _postBloc;
  ScrollController _FscrollController;
  ScrollController _SscrollController;

  @override
  void initState() {
    _FscrollController=ScrollController();
    _SscrollController=ScrollController();
    _dataBaseBloc = BlocProvider.of<DataBaseBloc>(context);
    _postBloc= BlocProvider.of<PostBloc>(context);
    _postBloc.add(GetUserPopulars(widget.gelenUser.userID));
    _dataBaseBloc.add(GetUserr(userID: widget.gelenUser.userID));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: _FscrollController,
        padding: EdgeInsets.all(0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(height: MediaQuery.of(context).size.height),
          child: Container(
            color: Colors.black,
            child: BlocListener(
              bloc: _dataBaseBloc,
              listener: (context, state) {},
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
                      content: Text("Tospik internetinde bi sıkıntı var galiba"),
                      backgroundColor: Colors.red,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else if (state is DataBaseLoadedState) {
                    User gelenUser = state.user;
                    return Column(
                      children: [
                        Center(
                            child: SafeArea(
                                child:
                                    profilePicturew(gelenUser.profilURL, context))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                            child: RaisedButton(
                              elevation: 15,
                              onPressed: () {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileEditPage(
                                                editingUser: gelenUser,
                                              )));
                                });
                              },
                              child: Text("Profili düzenle"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            gelenUser.userName,
                            style: GoogleFonts.righteous(
                                fontSize: 25, color: Theme.of(context).accentColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Container(
                            child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: getBadgeNumbers(gelenUser.roller),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 3.2,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 5,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return badgeMaker(index, gelenUser);
                                }),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Popüler İddiaları",
                                style: GoogleFonts.righteous(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 25),
                              ),
                            )),
                        lineDivider(),
                        SingleChildScrollView(
                          controller: _SscrollController,
                          child: Container(
                            height: MediaQuery.of(context).size.height/3,
                            child: BlocBuilder(
                              bloc: _postBloc,
                              // ignore: missing_return
                              builder: (context,state){
                                if(state is PostLoadingState){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                else if(state is PostErrorState){
                                  var snackbar= SnackBar(content: Text("Bir hata oluştu tospik. Tekrar dener misin ?"),backgroundColor: Colors.red,);
                                  Scaffold.of(context).showSnackBar(snackbar);
                                }
                                else if(state is PostLoadedState){
                                  List<Post> listPost=state.listPost;
                                  if(listPost.length!=0){
                                    return AnimationLimiter(
                                      child: ListView.builder(
                                          padding: EdgeInsets.all(0),
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          itemBuilder: (contex, index) {
                                            return AnimationConfiguration.staggeredList(
                                                position: index,
                                                duration:
                                                const Duration(milliseconds: 875),
                                                child: ScaleAnimation(
                                                  child: FadeInAnimation(
                                                    child: postContainer(
                                                        bloc: _postBloc,
                                                        post: listPost[index],
                                                        width: MediaQuery.of(context).size.width,
                                                        height: MediaQuery.of(context).size.height,
                                                        context: context),
                                                  ),
                                                ));
                                          }),
                                    );
                                  }
                                  else return  Container(
                                    color: Colors.black,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "Henüz paylaştığın bi iddian yok tospik."+gelenUser.roller['gMatik'].toString(),
                                            style: GoogleFonts.righteous(
                                                color: Colors.redAccent,
                                                fontSize: 25),
                                          ),
                                        )),
                                  );
                                }
                                else return Center(child: CircularProgressIndicator(),);
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}


int getBadgeNumbers(Map gelenMap){
  int counter=0;
  for(bool i in gelenMap.values){
    if(i){
      counter++;
    }

  }
  return counter;
}
