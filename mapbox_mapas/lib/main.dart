import 'package:flutter/material.dart';
import 'package:mapbox_mapas/src/views/full_screen_map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FullScreenMap(),
      ),
    );
  }
}
