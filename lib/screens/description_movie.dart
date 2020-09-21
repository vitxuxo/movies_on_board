import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_on_board/models/filme_model.dart';

import 'home_screen.dart';

class DescriptionMovie extends StatelessWidget {
  final FilmeModel filme;
  const DescriptionMovie({Key key, this.filme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    MediaQuery.of(context).orientation;
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/gif/stars.gif"), fit: BoxFit.cover)),
      height: screensize.height,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            elevation: 0,
            actions: [
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  }),
            ],
            title: Text(this.filme.titulo),
            backgroundColor: Colors.lightBlue[200]),
        body: GestureDetector(
          child: Container(
            width: screensize.width,
            height: screensize.height,
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: this.filme.poster,
                      height: screensize.height * 0.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        this.filme.titulo,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        this.filme.data,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        this.filme.genero,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        this.filme.sinopse,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        this.filme.sinopseFull,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
