import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:mucbirsebepler/widgets/randomGradient.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                ),
                child: Container(
                  color: Theme.of(context).accentColor,
                  width: width,
                  height: height / 7,
                  child: Align(
                      alignment: Alignment.center,
                      child: GradientText(
                        "Mücbir Mağaza",
                        gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Colors.red]),
                        style: GoogleFonts.righteous(fontSize: 35),
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 300),
                  topRight: Radius.circular(80),
                  bottomRight: Radius.circular(150.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: Container(
                  width: width / 1.2,
                  height: height / 5.6,
                  color: Colors.pinkAccent,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 66,top: 8),
                                  child: Text(
                                    "Gradient Tik",
                                    style: GoogleFonts.righteous(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50,right: 10),
                                child: Text(
                                  "Gradient Tikli olarak hem Bartu ve Melikşah'a öncelikli olarak gözüküp hem de bize destek verebilirsin",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50,top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.symmetric(vertical: BorderSide(color: Colors.cyan,width: 4.0),horizontal: BorderSide(color: Colors.deepPurpleAccent,width: 4.0))
                                        ),
                                        width: 70,
                                        height: 70,
                                        child: Image.asset("assets/renkli.gif",fit: BoxFit.fill,),
                                      ),
                                      SizedBox(width: 30,),
                                      RaisedButton(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        color: Colors.limeAccent,
                                        onPressed: (){},
                                        child: Text("Satın Al 10 ₺",style: GoogleFonts.bangers(fontSize: 26),),
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 300),
                  topRight: Radius.circular(80),
                  bottomRight: Radius.circular(150.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: Container(
                  width: width / 1.2,
                  height: height / 5.6,
                  color: Colors.cyanAccent,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 66,top: 14),
                                  child: Text(
                                    "MAtik",
                                    style: GoogleFonts.righteous(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50,right: 10),
                                child: Text(
                                  "Yeter artık instagram! Sen vermezsen biz kendimiz alırız matikimizi sitemidir bu",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50,top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.symmetric(vertical: BorderSide(color: Colors.pink,width: 4.0),horizontal: BorderSide(color: Colors.deepPurpleAccent,width: 4.0))
                                        ),
                                        width: 70,
                                        height: 70,
                                        child: Image.asset("assets/renksiz.gif",fit: BoxFit.fill,),
                                      ),
                                      SizedBox(width: 30,),
                                      RaisedButton(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        color: Colors.limeAccent,
                                        onPressed: (){},
                                        child: Text("Satın Al 20 ₺",style: GoogleFonts.bangers(fontSize: 26),),
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 300),
                  topRight: Radius.circular(80),
                  bottomRight: Radius.circular(150.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: Container(
                  width: width / 1.2,
                  height: height / 5.6,
                  color: Colors.greenAccent,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 66,top: 14),
                                  child: Text(
                                    "Destekçi Rozeti",
                                    style: GoogleFonts.righteous(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50,right: 10),
                                child: Text(
                                  "Destekçi rozetini alarak hem profilinizde sergileyebilir hem de bana 1/2 Starbucks Kahvesi ısmarlayabilirsiniz",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50,top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.symmetric(vertical: BorderSide(color: Colors.pink,width: 4.0),horizontal: BorderSide(color: Colors.deepPurpleAccent,width: 4.0))
                                        ),
                                        width: 70,
                                        height: 70,
                                        child: Image.asset("assets/icon/destek.png",fit: BoxFit.fill,),
                                      ),
                                      SizedBox(width: 30,),
                                      RaisedButton(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        color: Colors.limeAccent,
                                        onPressed: (){},
                                        child: Text("Satın Al 10 ₺",style: GoogleFonts.bangers(fontSize: 26),),
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 300),
                  topRight: Radius.circular(80),
                  bottomRight: Radius.circular(150.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                child: Container(
                  width: width / 1.2,
                  height: height / 5.6,
                  color: Colors.orangeAccent,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Align(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 66,top: 14),
                                  child: Text(
                                    "Ürün Yerleştirici",
                                    style: GoogleFonts.righteous(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        letterSpacing: 1.5),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50,right: 10),
                                child: Text(
                                  "Ürün yerleştirmek artık çok daha kolay,Satın aldıktan sonra sizinle iletişime geçilecektir",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50,top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.symmetric(vertical: BorderSide(color: Colors.pink,width: 4.0),horizontal: BorderSide(color: Colors.deepPurpleAccent,width: 4.0))
                                        ),
                                        width: 70,
                                        height: 70,
                                        child: Image.asset("assets/icon/yerles.png",fit: BoxFit.fill,),
                                      ),
                                      SizedBox(width: 30,),
                                      RaisedButton(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        color: Colors.limeAccent,
                                        onPressed: (){},
                                        child: Text("Satın Al 100 ₺",style: GoogleFonts.bangers(fontSize: 26),),
                                      )
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }
}
