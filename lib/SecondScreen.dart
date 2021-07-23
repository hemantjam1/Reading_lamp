import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screen/screen.dart';

class SecondPage extends StatefulWidget {
  final double brightness;
  final Color color;
  final bool isScreenAwake;

  const SecondPage({Key key, this.brightness, this.color, this.isScreenAwake})
      : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  screen() {
    Screen.setBrightness(widget.brightness);
    Screen.keepOn(widget.isScreenAwake);
  }

  flutterToastShow() {
    Fluttertoast.showToast(
        msg: widget.isScreenAwake
            ? 'Press back button to exit'
            : 'Tab the screen to go back');
  }

  @override
  void initState() {
    flutterToastShow();
    screen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Material(
        child: InkWell(
          onTap: () {
            if (!widget.isScreenAwake) {
              Navigator.pop(context);
            }
          },
          child: Container(color: widget.color),
        ),
      ),
    );
  }
}
