import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_button/flutter_reactive_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:linear_gradient/linear_gradient.dart';
import 'package:mucbirsebepler/bloc/authbloc/bloc.dart';
import 'package:mucbirsebepler/bloc/databasebloc/data_base_bloc.dart';
import 'package:mucbirsebepler/bloc/postbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';
import 'package:mucbirsebepler/model/user.dart';
import 'package:mucbirsebepler/pages/profilePage.dart';
import 'package:mucbirsebepler/util/badgeNames.dart';
import 'package:mucbirsebepler/widgets/profileHelper.dart';
import 'package:mucbirsebepler/widgets/randomGradient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget backButton(BuildContext context) {
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

Widget divider() {
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
        Text(
          'ya da',
          style: TextStyle(color: Colors.deepPurpleAccent),
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
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget lineDivider() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Divider(
              color: Colors.limeAccent,
              thickness: 1,
            ),
          ),
        ),
        Text(
          "...",
          style: TextStyle(color: Colors.limeAccent),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Divider(
              color: Colors.limeAccent,
              thickness: 1,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget facebookButton(AuthBloc authBloc) {
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
                  bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
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
              authBloc.add(GoogleSign());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Google ile Giriş Yap',
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

BuildContext gelenContext;
List<Color> colorCombination = LinearGradientStyle.getColorCombination(
    gradientType: LinearGradientStyle.GRADIENT_TYPE_ROYAL);

Post gelenPost;

Widget postCoontainer(
    {Post post,
    double width,
    double height,
    BuildContext context,
    bloc,
    User gelenUser,LinearGradient linearGradient}) {
  bool youtubeVarMi = false;
  bool linkVarMi = false;
  youtubeVarMi = post.youtubelink != "";
  linkVarMi = post.otherLink != "";
  YoutubePlayerController _controller;
  LinearGradient openedGradient= randomGradient();
  if (youtubeVarMi) {
    String videoID = YoutubePlayer.convertUrlToId(post.youtubelink);
    if (videoID == null) {
      videoID = "4YKpBYo61Cs";
    }
    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: YoutubePlayerFlags(
        hideThumbnail: true,
        autoPlay: false,
        mute: false,
      ),
    );
  }
  LinearGradient closedGradient = randomGradient();
  if(linearGradient!=null){
    closedGradient=linearGradient;
  }

  return OpenContainer(
    transitionDuration: Duration(milliseconds: 800),
    closedColor: Colors.transparent,
    openColor: Colors.white12,
    transitionType: ContainerTransitionType.fade,
    closedBuilder: (BuildContext context, VoidCallback voidCallBack) {
      return postContainer(
          post: post,
          width: width,
          height: height,
          context: context,
          bloc: bloc,
          gelenUser: gelenUser,
          voidCallback: voidCallBack,
          linearGradient: closedGradient);
    },
    openBuilder: (BuildContext context, VoidCallback voidCallBack) {
      return detailContainer(
        linearGradientt: openedGradient,
          context: context,
          gelenUser: gelenUser,
          linearGradient: closedGradient,
          gelenPost: post,
          controller: _controller,
          youtubeVarMi: youtubeVarMi,
          linkVarMi: linkVarMi);
    },
  );
}

Widget detailContainer(
    {BuildContext context,
    User gelenUser,
    LinearGradient linearGradient,
      LinearGradient linearGradientt,
    Post gelenPost,
    bool youtubeVarMi,
    YoutubePlayerController controller,
    bool linkVarMi}) {
  return Container(
      decoration: BoxDecoration(gradient: linearGradient),
      height: 100,
      child: SingleChildScrollView(
        controller: ScrollController(),
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
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiBlocProvider(
                    providers: [
                      BlocProvider<PostBloc>(create: (context)=>PostBloc(),),
                      BlocProvider<DataBaseBloc>(create: (context)=>DataBaseBloc(),)
                    ],
                    child: ProfilePage(
                      gelenUser: gelenPost.owner ,
                      tiklayanUser: gelenUser,
                    ),
                  )));
                },
                child: profilePicturew(gelenPost.owner, context,linearGradient: linearGradientt)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Container(
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: getBadgeNumbers(gelenPost.owner.roller).length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3.2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      List<String> roller =
                      getBadgeNumbers(gelenPost.owner.roller);
                      return badgeMaker(
                          index, gelenPost.owner, roller[index]);
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: Text(
                gelenPost.owner.userName + " iddiası",
                style: GoogleFonts.righteous(
                    fontSize: 17, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 0, 5),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Haber Başlığı",
                        style: GoogleFonts.anton(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        gelenPost.title,
                        style: GoogleFonts.righteous(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 25, 60, 5),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Haber İçeriği",
                        style: GoogleFonts.anton(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.black),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        gelenPost.description,
                        style: GoogleFonts.righteous(
                            fontSize: 15, fontWeight: FontWeight.w100),
                      )),
                ],
              ),
            ),
            linkVarMi
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(50, 25, 60, 5),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Linkler",
                              style: GoogleFonts.anton(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100,
                                  color: Colors.black),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: RaisedButton(
                              child: Text(gelenPost.otherLink),
                              onPressed: () async {
                                String url = gelenPost.otherLink;
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            )),
                      ],
                    ),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
            youtubeVarMi
                ? Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.height / 3,
                    child: YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                      progressColors: ProgressBarColors(
                          playedColor: Colors.limeAccent,
                          bufferedColor: Colors.cyan),
                    ),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
            SizedBox(height: 30,)
          ],
        ),
      ));
}

Widget postContainer(
    {Post post,
    double width,
    double height,
    BuildContext context,
    bloc,
    User gelenUser,
    VoidCallback voidCallback,
    LinearGradient linearGradient}) {
  gelenContext = context;
  PostBloc gelenBloc = bloc;
  gelenPost = post;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: voidCallback,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(200, 300),
          topRight: Radius.circular(80),
          bottomRight: Radius.circular(150.0),
          bottomLeft: Radius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(gradient: linearGradient),
          width: width,
          height: height / 4,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: badgeleriGetir(post.owner.roller),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              post.owner.userName,
                              style: GoogleFonts.righteous(fontSize: 15),
                            ),
                            Text(
                              "Tarafından paylaşıldı",
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                debugPrint("bas");
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  post.owner.profilURL,
                                ),
                                backgroundColor: Colors.black,
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 40,
                child: Container(
                  child: Text(
                    post.title,
                    style: GoogleFonts.abrilFatface(fontSize: height/50),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 40,
                child: Container(
                  width: width / 1.5,
                  child: RichText(
                    text: TextSpan(
                      text: post.description.length > 60
                          ? post.description.substring(0, 60) + "... "
                          : post.description + "... ",
                      style: GoogleFonts.roboto(
                          fontSize: height/55, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {},
                            text: 'Daha fazlasını gör',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 30,
                child: Row(
                  children: <Widget>[
                    ReactiveButton(
                      containerAbove: false,
                      child: CircleAvatar(
                        radius: height/50,
                          backgroundColor: Colors.red,
                          child: Icon(
                            LineAwesomeIcons.heart_o,
                            size: height/30,
                          )),
                      icons: _facebook,
                      //_flags,
                      onTap: () {
                        Scaffold.of(gelenContext).showSnackBar(SnackBar(
                          content: Text("Lütfen Basılı tutunuz"),
                          backgroundColor: Colors.deepPurple,
                          duration: Duration(milliseconds: 500),
                        ));
                      },
                      onSelected: (ReactiveIconDefinition button) {
                        gelenBloc.add(LikePost(
                            postID: post.postID, userID: gelenUser.userID,ownerUserID: post.owner.userID));
                      },
                      iconWidth: 32.0,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    StreamBuilder(
                      stream: Firestore.instance
                          .collection("posts")
                          .document(post.postID)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data["liked"].toString() +
                                " Kere Beğenildi",
                            style: GoogleFonts.righteous(fontSize: height/50),
                          );
                        } else
                          return Text(
                            "X Kere Beğenildi",
                            style: GoogleFonts.righteous(fontSize: height/50),
                          );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget entryField(
    {String title,
    TextEditingController textEditingController,
    FaIcon faIcon}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.righteous(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            validator: (e) {
              String yazilacak;

              if (title == "Haber Başlığı(Zorunlu)") {
                if (e.isEmpty) yazilacak = "Lütfen Başlığı giriniz";
              }
              if (title == "Haber İçeriği(Zorunlu)") {
                if (e.isEmpty) yazilacak = "Lütfen içeriği giriniz";
              }
              if (title == "Youtube Linki") {
                if (e != "" && !e.contains("youtube")) {
                  if (!e.contains("youtu.be")) if (!e.contains("https"))
                    yazilacak = "Lütfen sadece youtube linki giriniz";
                } else {
                  if (!e.contains("https://") && e != "")
                    yazilacak = "Lütfen https:// ekleyin";
                }
              }
              return yazilacak;
            },
            maxLines: null,
            style: GoogleFonts.roboto(color: Colors.limeAccent),
            controller: textEditingController,
            cursorColor: Colors.limeAccent,
            keyboardType: TextInputType.text,
            maxLength: title == "Haber Başlığı(Zorunlu)" ? 35 : 200,
            decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.limeAccent),
                hoverColor: Colors.limeAccent,
                focusColor: Colors.limeAccent,
                suffixIcon: faIcon,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.limeAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lime),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lime)),
                fillColor: Colors.white12,
                errorStyle: GoogleFonts.adventPro(
                    fontSize: 15,
                    color: Colors.limeAccent,
                    fontWeight: FontWeight.bold),
                filled: true))
      ],
    ),
  );
}

List<String> getBadgeNumberss(Map gelenMap) {
  List<String> rolleri = [];
  for (var i in gelenMap.entries) {
    if (i.value) {
      rolleri.add(i.key);
    }
  }
  return rolleri;
}

List<Widget> badgeleriGetir(Map rollerMap) {
  List<Widget> badgeListe = [];
  List<String> roller = getBadgeNumberss(rollerMap);
  List<int> indexler = [];
  for (int j = 0; j < firebaseBadgeNames.length; j++) {
    for (int i = 0; i < roller.length; i++) {
      if (firebaseBadgeNames[j] == roller[i]) {
        indexler.add(j);
      }
    }
  }

  for (int i = 0; i < indexler.length; i++) {
    badgeListe.add(Padding(
      padding: const EdgeInsets.all(2.0),
      child:
          Align(alignment: Alignment.topRight, child: badgeIcons[indexler[i]]),
    ));
  }

  return badgeListe;
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



List<ReactiveIconDefinition> _facebook = <ReactiveIconDefinition>[
  ReactiveIconDefinition(
    assetIcon: 'assets/j.gif',
    code: 'j',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/veri.gif',
    code: 'tik',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/lg.gif',
    code: 'lgbt',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/garnit.gif',
    code: 'garnit',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/edis.png',
    code: 'edis',
  ),
];
