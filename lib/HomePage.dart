import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mopub_flutter/mopub_banner.dart';
import 'package:reading_lamp/Widgets.dart';
import 'package:screen/screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mopub_flutter/mopub.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'SecondScreen.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double _brightness = 0.3;
  Color pickerColor = Color(0xff2FE900); //4281329920
  Color bgColor = Colors.black38;
  Color shadowLightColor = Colors.white38;
  Color shadowDarkColor = Colors.black;
  Color customTextColor = Color(0xff2FE900);
  String androidId = 'd7531ea05d6a468b9429f782a135370c'; //android Banner id
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void mopubAd() {
    try {
      MoPub.init(androidId);
    } on PlatformException {}
  }

  Widget showAd() {
    return Platform.isIOS
        ? Container(height: 20)
        : MoPubBannerAd(
            adUnitId: androidId,
            bannerSize: BannerSize.STANDARD,
            keepAlive: true,
            listener: (result, dynamic) {});
  }

  void setValue(String key, int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  getValue(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var res = pref.getInt(key) ?? 4281329920;
    return res;
  }

  void setBrightness(String key, double value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble(key, value);
  }

  getBrightness(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var res = pref.getDouble(key) ?? Screen.brightness;
    return res;
  }

  void getColor() async {
    int colorValue = await getValue('currentColor');
    pickerColor = Color(colorValue);
    setState(() {});
  }

  void setBrightnessValue() async {
    _brightness = await getBrightness('brightness');
  }

  Widget colorPicker() {
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
          surfaceIntensity: 0),
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 10,
          horizontal: MediaQuery.of(context).size.width / 95),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            child: const Text('Got it'),
            onPressed: () {
              setValue('currentColor', pickerColor.value);
              print(pickerColor.value);
              Navigator.of(context).pop();
            },
          )
        ],
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (chosenColor) {
                setState(() {
                  pickerColor = chosenColor;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8),
        ),
      ),
    );
  }

  @override
  void initState() {
    getColor();
    setBrightnessValue();
    mopubAd();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(color: Colors.grey[800]),
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSizedBox(height: 10, context: context),
                customizeText(text: 'Reading Lamp', fontSize: 42),
                customSizedBox(height: 10, context: context),
                Center(
                  child: NeumorphicButton(
                    child: Padding(
                        padding: EdgeInsets.all(30.0), child: SizedBox()),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      oppositeShadowLightSource: false,
                      intensity: 8,
                      shadowLightColor: Colors.white54,
                      shadowDarkColor: Colors.black,
                      color: pickerColor,
                      depth: 9,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    onPressed: () => showDialog(
                      builder: (context) {
                        return colorPicker();
                      },
                      context: context,
                    ),
                  ),
                ),
                customSizedBox(height: 25, context: context),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customizeButton(
                            onPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return colorPicker();
                                },
                              );
                            },
                            top: 4,
                            bottom: 4,
                            right: 10,
                            left: 10,
                            text: 'Change Color',
                            shadowDarkColor: shadowDarkColor,
                            shadowLightColor: shadowLightColor,
                            bgColor: bgColor,
                          ),
                          customizeButton(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SecondPage(
                                    color: pickerColor,
                                    brightness: _brightness,
                                    isScreenAwake: false,
                                  ),
                                ),
                              );
                            },
                            top: 4,
                            bottom: 4,
                            right: 35,
                            left: 35,
                            text: "Test",
                            shadowDarkColor: shadowDarkColor,
                            shadowLightColor: shadowLightColor,
                            bgColor: bgColor,
                          ),
                        ],
                      ),
                      customSizedBox(height: 25, context: context),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customizeText(
                              text: 'Brightness :  ',
                              fontSize: 18,
                              textColor: customTextColor),
                          customSizedBox(height: 25, context: context),
                          NeumorphicSlider(
                            style: SliderStyle(
                                variant: customTextColor,
                                depth: 2,
                                accent: customTextColor),
                            value: _brightness,
                            onChanged: (double b) {
                              setState(() {
                                _brightness = b;
                                setBrightness("brightness", b);
                              });
                            },
                          )
                        ],
                      ),
                      customSizedBox(height: 25, context: context),
                      customizeButton(
                        top: 4,
                        right: 105,
                        left: 105,
                        bottom: 4,
                        text: 'Start',
                        onPress: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SecondPage(
                              color: pickerColor,
                              brightness: _brightness,
                              isScreenAwake: true,
                            ),
                          ),
                        ),
                        bgColor: bgColor,
                        shadowLightColor: shadowLightColor,
                        shadowDarkColor: shadowDarkColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return about(
                      shadowDarkColor: shadowDarkColor,
                      shadowLightColor: shadowLightColor,
                      context: context,
                      customTextColor: customTextColor,
                    );
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 25),
                child: customizeText(
                    text: 'ABOUT', fontSize: 20, textColor: customTextColor),
              ),
            ),
            showAd()
          ],
        ),
      ),
    );
  }
}
