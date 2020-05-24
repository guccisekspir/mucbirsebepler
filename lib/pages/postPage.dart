import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mucbirsebepler/bloc/databasebloc/bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/widgets/uiHelperWidgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PostPage extends StatefulWidget {
  final User user;

  const PostPage({Key key, this.user}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostBloc _postBloc;
  DataBaseBloc _dataBaseBloc;
  User cekilenUser;
  TextEditingController headerController;
  TextEditingController descController;
  TextEditingController youtubeController;
  TextEditingController otherController;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    headerController = TextEditingController(text: "");
    descController = TextEditingController(text: "");
    youtubeController = TextEditingController(text: "");
    otherController = TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (_) => FlareGiffyDialog(
          cardBackgroundColor: Colors.black,
          onlyOkButton: true,
          flarePath: 'assets/minion.flr',
          flareAnimation: 'Wave',
          title: Text(
            '        Haber Paylaşmaya  \n'
                'Çalıştığınızı görüntülüyorum',
            maxLines: null,
            style: GoogleFonts.righteous(
                fontSize: 10, color: Colors.deepPurpleAccent),
          ),
          description: Text(
            "Şimdilik video veya fotoğraf yükleyemiyoruz.\n"
                " Lütfen içerikleri youtube veya farklı yere yükleyip burada belirtiniz.",
            textAlign: TextAlign.center,
            style: GoogleFonts.righteous(color: Colors.deepOrange,fontSize: 8),
          ),
          entryAnimation: EntryAnimation.BOTTOM_LEFT,
          onOkButtonPressed: () {
            Navigator.of(context).pop();
          },
        )));

    _postBloc = BlocProvider.of<PostBloc>(context);
    _dataBaseBloc= BlocProvider.of<DataBaseBloc>(context);
    _dataBaseBloc.add(GetUserr(userID: widget.user.userID));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
    pr.style(backgroundColor: Colors.lime,
        messageTextStyle: TextStyle(color: Colors.black),
        message: "Gönderiliyor ..",
        borderRadius: 30);


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: MultiBlocListener(
        listeners: [
          BlocListener<PostBloc,PostState>(listener: (context,state){

            if(state is PostSavedState){
              pr.hide();
              showDialog( //TODO bunu uihelpera ekle
                  context: context,
                  builder: (_) => FlareGiffyDialog(
                    onlyOkButton: true,
                    flarePath: 'assets/dialog.flr',
                    flareAnimation: 'jump',
                    title: Text(
                      'Postun uzayın derinliklerine gönderildi',
                      style: GoogleFonts.righteous(fontSize: 16.0, fontWeight: FontWeight.w600,color: Colors.black),
                    ),
                    description: Text(
                      "Şaka şaka. Postun yayınlandı tospik",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.righteous(fontSize: 14.0, fontWeight: FontWeight.w600,color: Colors.black),
                    ),
                    entryAnimation: EntryAnimation.BOTTOM,
                    onOkButtonPressed: () {
                      Navigator.of(context).pop();
                    },
                  ));

            }

            if(state is PostSaveErrorState){
              pr.hide();
              showDialog(
                  context: context,
                  builder: (_) => FlareGiffyDialog(
                    onlyOkButton: true,
                    flarePath: 'assets/dialog.flr',
                    flareAnimation: 'jump',
                    title: Text(
                      'Bir şeyler ters gitti Tospik',
                      style: GoogleFonts.righteous(fontSize: 16.0, fontWeight: FontWeight.w600,color: Colors.black),
                    ),
                    description: Text(
                      "Daha sonra tekrar deneyebilir misin ? ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.righteous(fontSize: 14.0, fontWeight: FontWeight.w600,color: Colors.black),
                    ),
                    entryAnimation: EntryAnimation.TOP_RIGHT,
                    onOkButtonPressed: () {
                      Navigator.of(context).pop();
                    },
                  ));

            }
            if(state is PostSavingState){

              pr.show();
            }


          },),
          BlocListener<DataBaseBloc,DataBaseState>(listener: (context,state){
            if(state is DataBaseLoadedState){
              setState(() {
                cekilenUser=state.user;
              });

            }


          },)

        ],
        child: cekilenUser!=null?Container(
          color: Colors.black,
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: <Widget>[

              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100.0),
                        ),
                        child: Container(
                          color: Theme.of(context).accentColor,
                          width: screenWidth,
                          height: screenHeight / 7,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "İddia Paylaşım Yeri",
                              style: GoogleFonts.pressStart2p(
                                fontSize: screenHeight/45,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: entryField(
                            title: "Haber Başlığı(Zorunlu)",
                            textEditingController: headerController,
                            faIcon: FaIcon(
                              FontAwesomeIcons.horseHead,
                              color: Colors.deepOrange,
                              size: 30,
                            )),
                      ),
                      lineDivider(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: entryField(
                            title: "Haber İçeriği(Zorunlu)",
                            textEditingController: descController,
                            faIcon: FaIcon(
                              FontAwesomeIcons.userNinja,
                              color: Colors.deepOrange,
                              size: 30,
                            )),
                      ),

                      lineDivider(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: entryField(
                            title: "Youtube Linki",
                            textEditingController: youtubeController,
                            faIcon: FaIcon(
                              FontAwesomeIcons.youtube,
                              color: Colors.deepOrange,
                              size: 30,
                            )),
                      ),
                      lineDivider(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: entryField(
                            title: "Diğer Linkler",
                            textEditingController: otherController,
                            faIcon: FaIcon(
                              FontAwesomeIcons.slack,
                              color: Colors.deepOrange,
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState.validate()) {
                        Post gidecekPost = Post(
                          ownerProfileURL: cekilenUser.profilURL,
                          ownerUserName: cekilenUser.userName,
                            owner: cekilenUser,
                            title: headerController.text,
                            description: descController.text,
                            youtubelink: youtubeController.text,
                            otherLink: otherController.text);
                        _postBloc.add(SavePost(gelenPost: gidecekPost));
                        _postBloc.add(GetPost());
                      }
                    },
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepOrange,
                        child: Icon(
                          FontAwesomeIcons.plus,
                          size: 30,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}