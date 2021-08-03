import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.00),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://i.blogs.es/85aa44/stan-lee/1366_2000.jpg"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.00),
            child: CircleAvatar(
              child: Text("SL"),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          image: NetworkImage(
              "https://cdn.aarp.net/content/dam/aarp/entertainment/celebrities/stan-lee/promo-hulk-gloves-esp.imgcache.revc81d2b700e4f271b8a7b88efea2ef78b.jpg"),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
