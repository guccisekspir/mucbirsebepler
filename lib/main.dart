import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mucbirsebepler/bloc/authbloc/auth_bloc.dart';
import 'package:mucbirsebepler/locator.dart';
import 'package:mucbirsebepler/pages/splashScreen.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setupLocator();
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mücbir Sebepler',
        theme: ThemeData(
          accentColor: Colors.limeAccent,
          primaryColor: Colors.black,
        ),
        home: DenemeApp());
  }
}

class DenemeApp extends StatefulWidget {
  @override
  _DenemeAppState createState() => _DenemeAppState();
}

class _DenemeAppState extends State<DenemeApp> {
  bool ilkMi = true;
  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/hslgnd.png',
        title: Text('GÜ-NAY-DIN',
            style: GoogleFonts.righteous(fontSize: 28, color: Colors.black)),
        body: Text(
            'Günaydın Tospikk\n'
            'Uygulamama hoşgeldin',
            textAlign: TextAlign.center,
            style: GoogleFonts.righteous(fontSize: 17, color: Colors.white)),
        iconAssetPath: 'assets/icon/tospik.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/icon/acar.png',
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text('Acar Muhabirler vardır',
              style: GoogleFonts.righteous(fontSize: 25, color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Text(
              'Artık siz de mücbir sebeplere haber getiren acar muhabirlerden biri olabilirsiniz. Tek yapmanız gereken uygulamamızı kullanmak',
              textAlign: TextAlign.center,
              style: GoogleFonts.righteous(fontSize: 17, color: Colors.white)),
        ),
        iconAssetPath: 'assets/icon/acar.png'),
    PageModel(
        color: const Color(0xFF9B90BC),
        heroAssetPath: 'assets/mekik.png',
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text('Unutma! .',
              style: GoogleFonts.righteous(fontSize: 25, color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Text(
              'Matikli veya GradientTikli iseniz Bartu ve Melikşah İddialarınız daha önce görür !',
              textAlign: TextAlign.center,
              style: GoogleFonts.righteous(fontSize: 17, color: Colors.white)),
        ),
        iconAssetPath: 'assets/icon/popular.png'),
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/icon/destek.png',
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text('Bi de şey...',
              style: GoogleFonts.righteous(fontSize: 25, color: Colors.black)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Text(
              'Deskteçi Tospik rozetini satın alarak bana destek olabilirsiniz. Şimdiden hepinize teşekkürler',
              textAlign: TextAlign.center,
              style: GoogleFonts.righteous(fontSize: 17, color: Colors.white)),
        ),
        iconAssetPath: 'assets/icon/destek.png'),
  ];

  Future<Null> _function() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("ilkMi") != null) {
        setState(() {
          ilkMi = false;
        });
      } else {
        ilkMi = true;
      }
    });
  }

  @override
  void initState() {
    _function();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ilkMi
        ? Scaffold(
            body: FancyOnBoarding(
              doneButtonText: "Bitti",
              skipButtonText: "Geç",
              onDoneButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => AuthBloc(),
                          child: SplashScreen())),
                );
              },
              onSkipButtonPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => AuthBloc(),
                            child: SplashScreen())),
                    (Route<dynamic> route) => false);
              },
              pageList: pageList,
            ),
          )
        : BlocProvider(create: (context) => AuthBloc(), child: SplashScreen());
  }
}
