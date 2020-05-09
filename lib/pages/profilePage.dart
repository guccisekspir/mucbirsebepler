import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/pages/postPage.dart';
import 'package:mucbirsebepler/pages/profileEditPage.dart';

class ProfilePage extends StatefulWidget {
  final User gelenUser;

  const ProfilePage({Key key, this.gelenUser}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DataBaseBloc _dataBaseBloc;

  @override
  void initState() {
    _dataBaseBloc = BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetUserr(userID: widget.gelenUser.userID));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.limeAccent,
        child: BlocListener(
          bloc: _dataBaseBloc,
          listener: (context, state) {},
          child: BlocBuilder(
            bloc: _dataBaseBloc,
            // ignore: missing_return
            builder: (context, state) {
              if (state is DataBaseLoadingState) {
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
                      child: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 95,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(gelenUser.profilURL),
                          radius: 80,
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                      ),
                    )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: RaisedButton(
                          elevation: 15,
                          onPressed: (){

                            WidgetsBinding.instance.addPostFrameCallback((_){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileEditPage(editingUser: gelenUser,)));
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
                        style: GoogleFonts.righteous(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Expanded(
                        child: Container(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                              itemCount: 4,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3.2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 5,
                                crossAxisCount: 2

                              ), itemBuilder: (context,index){
                            return BadgeMaker(index,gelenUser);
                          }),
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
    );
  }
}

Widget BadgeMaker(int index,User gelenUser){

  return FittedBox(

    child: Container(

      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        CircleAvatar(child: Icon(Icons.star,size: 10,color: Colors.deepPurpleAccent,),radius: 10,backgroundColor: Colors.deepOrangeAccent,),
        Text(" Ayın Muhabiri $index ",style: GoogleFonts.righteous(fontSize: 10),)
      ],),
    ),
  );

}
