import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_on_board/blocs/favorites_bloc.dart';
import 'package:movies_on_board/models/filme_model.dart';
import 'package:movies_on_board/screens/home_screen.dart';

import 'description_movie.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).orientation;
    return AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/gif/stars.gif"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Icon((Icons.movie)),
            elevation: 0,
            actions: [
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  }),
            ],
            title: Text(
              "Favorites",
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            ),
            backgroundColor: Colors.lightBlue[200],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<FavoritesBloc, List<FilmeModel>>(
                      builder: (context, state) {
                    if (state == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.75),
                        itemCount: state.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DescriptionMovie(
                                            filme: state[index])));
                              },
                              child: CachedNetworkImage(
                                imageUrl: state[index].poster,
                                height: 130,
                              ),
                            ),
                            ListTile(
                                title: Text(
                              state[index].titulo,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(3, 1, 2, 0),
                                  child: IconButton(
                                    icon: Icon(
                                      state.isEmpty
                                          ? Icons.star_border
                                          : Icons.star,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      context
                                          .bloc<FavoritesBloc>()
                                          .removeFavorite(state[index]);
                                      _showNotification(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                )
              ],
            ),
          ),
        ));
  }

  void _showNotification(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text('Removed from favorite'),
    ));
  }
}
