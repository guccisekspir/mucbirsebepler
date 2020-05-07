import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_button/flutter_reactive_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_gradient/linear_gradient.dart';
import 'package:mucbirsebepler/bloc/authbloc/bloc.dart';
import 'package:mucbirsebepler/model/post.dart';


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
              color: Colors.deepPurpleAccent,
              thickness: 1,
            ),
          ),
        ),
        Text(
          "...",
          style: TextStyle(color: Colors.deepPurple),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Divider(
              color: Colors.deepPurpleAccent,
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

List<Color> colorCombination = LinearGradientStyle.getColorCombination(
    gradientType: LinearGradientStyle.GRADIENT_TYPE_ROYAL);

Widget postContainer({Post post, double width, double height}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: <Widget>[

        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(200, 300),
            topRight: Radius.circular(80),
            bottomRight: Radius.circular(150.0),
            bottomLeft: Radius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradientStyle.linearGradient(
                    orientation: LinearGradientStyle.ORIENTATION_HORIZONTAL,
                    gradientType: Random().nextInt(200))),
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
                          Row(children: badgeleriGetir(),),

                          Column(
                            children: <Widget>[
                              Text(
                                post.owner.userName,
                                style: GoogleFonts.righteous(fontSize: 15),
                              ),
                              Text(
                                "Tarafından paylaşıldı",
                                style: GoogleFonts.roboto(
                                    fontSize: 10, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  post.owner.profilURL,
                                ),
                                backgroundColor: Colors.black,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top:80,
                  left: 30,
                  child: Container(
                    child: Text(
                      post.title,
                      style: GoogleFonts.fredokaOne(fontSize: 16),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 30,
                  child: Container(
                    width: width/1.5,
                    child: Text(
                      post.description.length>60?post.description.substring(0,60):post.description,
                      style: GoogleFonts.roboto(fontSize: 14),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 30,
                  child: buton,
                )
              ],
            ),
          ),
        ),

      ],

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
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            validator: (e) {
              String yazilacak;

              if (title == "Haber Başlığı") {
                if (e.isEmpty) yazilacak = "Lütfen Başlığı giriniz";
              }
              if (title == "Haber İçeriği") {
                if (e.isEmpty) yazilacak = "Lütfen içeriği giriniz";
              }
              if (title == "Youtube Linki") {
                if (e != "" && !e.contains("youtube"))
                  yazilacak = "Lütfen sadece youtube linki giriniz";
              }
              return yazilacak;
            },
            maxLines: null,
            style: GoogleFonts.roboto(color: Colors.deepPurple),
            controller: textEditingController,
            cursorColor: Colors.deepPurpleAccent,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                suffixIcon: faIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                errorStyle: GoogleFonts.adventPro(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                fillColor: Colors.black,
                filled: true))
      ],
    ),
  );
}

List<Widget> badgeleriGetir(){
  List<Widget> liste=[];
  liste.add(Padding(
    padding: const EdgeInsets.all(2.0),
    child: Align(alignment: Alignment.topRight,
        child: CircleAvatar(child: Center(child: Icon(FontAwesomeIcons.star,size: 16,)),radius: 16,)),
  ));
  liste.add(Padding(
    padding: const EdgeInsets.all(2.0),
    child: Align(alignment: Alignment.topRight,
        child: CircleAvatar(child: Center(child: Icon(FontAwesomeIcons.star,size: 16,)),radius: 16,)),
  ));
  liste.add(Padding(
    padding: const EdgeInsets.all(2.0),
    child: Align(alignment: Alignment.topRight,
        child: CircleAvatar(child: Center(child: Icon(FontAwesomeIcons.star,size: 16,)),radius: 16,)),
  ));
  return liste;
}

String facebook;

Widget buton = ReactiveButton(
  containerAbove: false,
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 1.0,
      ),
      color: Colors.white,
    ),
    width: 80.0,
    height: 40.0,
    child: Center(
      child: facebook == null
          ? Text('click')
          : Image.asset(
        'assets/edis.png',
        width: 32.0,
        height: 32.0,
      ),
    ),
  ),
  icons: _facebook, //_flags,
  onTap: () {
    print('TAP');
  },
  onSelected: (ReactiveIconDefinition button) {
    facebook=button.code;
    debugPrint(button.code);
  },
  iconWidth: 32.0,
);



List<ReactiveIconDefinition> _facebook = <ReactiveIconDefinition>[
  ReactiveIconDefinition(
    assetIcon: 'assets/edis.png',
    code: 'like',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/j.gif',
    code: 'haha',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/veri.gif',
    code: 'love',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/lg.gif',
    code: 'sad',
  ),
  ReactiveIconDefinition(
    assetIcon: 'assets/garnit.gif',
    code: 'wow',
  ),
];


