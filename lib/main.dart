import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reading_lamp/HomePage.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      NeumorphicApp(
        theme: NeumorphicThemeData(baseColor: Colors.black38),
        title: 'Reading Lamp',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}
