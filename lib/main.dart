// @dart=2.9

import 'package:flutter/material.dart';
import 'package:poke/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

// sprites->other->official-artwork->front_default -> imagen de pokemon 

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  HomePage(),
    );
  }
}

