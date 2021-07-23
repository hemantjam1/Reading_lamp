import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

customizeText(
    {@required String text,
    @required double fontSize,
    Color textColor = Colors.white}) {
  return NeumorphicText(
    text,
    style: NeumorphicStyle(
      color: textColor,
      depth: 2,
      shape: NeumorphicShape.convex,
    ),
    textStyle:
        NeumorphicTextStyle(fontWeight: FontWeight.w200, fontSize: fontSize),
  );
}

Widget about(
    {@required BuildContext context,
    @required Color shadowLightColor,
    @required Color shadowDarkColor,
    @required Color customTextColor}) {
  String email = 'manektech2021@gmail.com';
  String subject = 'Regarding Reading Lamp FeedBack';
  return Neumorphic(
    style: NeumorphicStyle(
      lightSource: LightSource.topLeft,
      color: Colors.black,
      shadowLightColor: shadowLightColor,
      shadowDarkColor: shadowDarkColor,
      depth: 3,
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      intensity: 1,
      surfaceIntensity: 0,
    ),
    margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 3,
        horizontal: MediaQuery.of(context).size.width / 10),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              textScaleFactor: 1.1,
              text: TextSpan(
                style: TextStyle(fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: 'About\n\n',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextSpan(
                      text:
                          '     If you have a problem with the app, have feedback or other comments then you are welcome to write us an '),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        try {
                          await launch('mailto:$email?subject=$subject');
                        } catch (e) {}
                      },
                    text: 'Email',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: customTextColor),
                  ),
                  TextSpan(text: ' or visit our '),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        try {
                          await launch('https://www.manektech.com/');
                        } catch (e) {}
                      },
                    text: 'Website',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: customTextColor),
                  ),
                  TextSpan(text: '   \n\n   © 2021 ManekTech (v 1.0.0)'),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    try {
                      Navigator.of(context).pop();
                    } catch (e) {}
                  },
                text: '\nOK',
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget customSizedBox(
    {@required double height, @required BuildContext context}) {
  return SizedBox(height: MediaQuery.of(context).size.height / height);
}

customizeButton(
    {@required VoidCallback onPress,
    @required double left,
    @required double top,
    @required double right,
    @required double bottom,
    @required String text,
    @required Color bgColor,
    @required Color shadowLightColor,
    @required Color shadowDarkColor}) {
  return NeumorphicButton(
    child: Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: customizeText(text: text, fontSize: 16)),
    onPressed: onPress,
    style: NeumorphicStyle(
      lightSource: LightSource.topLeft,
      color: bgColor,
      shadowLightColor: shadowLightColor,
      shadowDarkColor: shadowDarkColor,
      depth: 3,
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      intensity: 1,
      surfaceIntensity: 0,
    ),
  );
}
