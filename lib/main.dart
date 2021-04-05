import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    title: 'Reading Lamp',
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _brightness = 0.3;
  Color pickerColor = Colors.orangeAccent;
  Color currentColor = Color(0xff443a49);
  Color fontColor = Colors.white;
  Color themeColor = Colors.grey[800];

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  setValue() async {
    return _brightness = await Screen.brightness;
  }

  Widget about() {
    String email = 'manektech2021@gmail.com';
    String subject = 'Regarding Reading Lamp FeedBack';
    return AlertDialog(
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
      title: Text('About'),
      content: RichText(
        text: TextSpan(style: TextStyle(color: Colors.black), children: [
          TextSpan(
              style: TextStyle(color: Colors.black),
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
                color: Colors.red,
              )),
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
                color: Colors.red,
              )),
          TextSpan(
            text: '   \n\n   © 2021 ManekTech (v 1.0.0)',
            style: TextStyle(color: Colors.black),
          )
        ]),
      ),
    );
  }

  Widget colorPicker() {
    return AlertDialog(
        actions: [
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
            child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: changeColor,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        )));
  }

  @override
  void initState() {
    setValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Container(
        color: themeColor,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Scaffold(
          body: Material(
              child: Container(
            color: themeColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reading Lamp',
                    style: TextStyle(
                      fontSize: 42,
                      color: fontColor,
                    ),
                  ),
                  SizedBox(
                    height: orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.height / 8
                        : MediaQuery.of(context).size.height / 7,
                  ),
                  Container(
                    width: orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width / 2
                        : MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: colorPicker(),
                                );
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                color: pickerColor,
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  child: colorPicker(),
                                );
                              },
                              child: Text('CHANGE COLOR'),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Page(
                                              color: pickerColor,
                                              brightness: _brightness,
                                              isScreenAwake: false,
                                            )));
                              },
                              child: Text('TEST'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Brightness :',
                              style: TextStyle(
                                color: fontColor,
                              ),
                            ),
                            Slider(
                                value: _brightness,
                                onChanged: (double b) {
                                  setState(() {
                                    _brightness = b;
                                  });
                                })
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'To exit the main app simply switch off the screen',
                          style: TextStyle(color: fontColor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Page(
                                          color: pickerColor,
                                          brightness: _brightness,
                                          isScreenAwake: true,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            height:
                                orientation == Orientation.landscape ? 50 : 55,
                            width: 100,
                            child: Center(
                                child: Text(
                              'START',
                              style: TextStyle(fontSize: 21),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
          bottomNavigationBar: orientation == Orientation.landscape
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    showDialog(context: context, child: about());
                  },
                  child: Container(
                    color: themeColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          color: fontColor,
                        ),
                        FlatButton(
                          color: themeColor,
                          onPressed: () {
                            showDialog(context: context, child: about());
                          },
                          child: Text(
                            'ABOUT',
                            style: TextStyle(color: fontColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class Page extends StatefulWidget {
  final double brightness;
  final Color color;
  final bool isScreenAwake;

  const Page({Key key, this.brightness, this.color, this.isScreenAwake})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  screen() {
    Screen.setBrightness(widget.brightness);
    Screen.keepOn(widget.isScreenAwake);
  }

  @override
  void initState() {
    screen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          if (!widget.isScreenAwake) {
            Navigator.pop(context);
          }
        },
        child: Container(
          color: widget.color,
        ),
      ),
    );
  }
}
