import 'package:designs/src/widgets/background.dart';
import 'package:designs/src/widgets/card_table.dart';
import 'package:designs/src/widgets/custom_bottom_navigation.dart';
import 'package:designs/src/widgets/page_title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Background(), _HomeBody()],
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [PageTitle(), CardTable()],
      ),
    );
  }
}
