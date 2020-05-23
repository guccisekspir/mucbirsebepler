import 'package:flutter/material.dart';



class BosPage extends StatefulWidget {
  @override
  _BosPageState createState() => _BosPageState();
}

class _BosPageState extends State<BosPage> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    // TODO: implement initState
    _textEditingController=TextEditingController(text: "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.limeAccent,
      child: Column(
        children: [
          Center(child: Text("userID"),),
          Center(child: TextField(
            controller: _textEditingController,

          ),)
        ],
      ),
    );
  }
}


