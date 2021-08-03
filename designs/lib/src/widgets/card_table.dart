import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _SingleCard(
            color: Colors.lightBlueAccent,
            icon: Icons.auto_awesome_mosaic,
            text: "General",
          ),
          _SingleCard(
              color: Colors.deepPurpleAccent,
              icon: Icons.train,
              text: "Transport"),
        ]),
        TableRow(children: [
          _SingleCard(
            color: Colors.pinkAccent,
            icon: Icons.shopping_bag_rounded,
            text: "Shopping",
          ),
          _SingleCard(
              color: Colors.orangeAccent, icon: Icons.assignment, text: "Bill"),
        ]),
        TableRow(children: [
          _SingleCard(
            color: Colors.blueAccent,
            icon: Icons.movie_sharp,
            text: "Entertaiment",
          ),
          _SingleCard(
              color: Colors.green, icon: Icons.nights_stay, text: "Grocery"),
        ]),
        TableRow(children: [
          _SingleCard(
            color: Colors.blueAccent,
            icon: Icons.auto_awesome_mosaic,
            text: "General",
          ),
          _SingleCard(
              color: Colors.deepPurpleAccent,
              icon: Icons.train,
              text: "Transport"),
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  _SingleCard(
      {Key? key, required this.icon, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            size: 35,
            color: Colors.white,
          ),
          radius: 35,
        ),
        SizedBox(
          height: 20,
        ),
        Text(text, style: TextStyle(color: color, fontSize: 18))
      ],
    ));
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;
  const _CardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 180.0,
            decoration: BoxDecoration(
                color: Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20)),
            child: this.child,
          ),
        ),
      ),
    );
  }
}
