import 'package:chika_metronome/screen/metronome/metronome_screen_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '地下メトロ',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MetronomeScreenPage(),
    );
  }
}
