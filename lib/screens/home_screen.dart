import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_on_board/blocs/favorites_bloc.dart';
import 'package:movies_on_board/blocs/listFilmes_bloc.dart';
import 'package:movies_on_board/models/filme_model.dart';
import 'package:movies_on_board/screens/description_movie.dart';
import 'package:movies_on_board/screens/favorites.dart';

class Home extends StatelessWidget {
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
              Row(
                children: [
                  BlocBuilder<FavoritesBloc, List<FilmeModel>>(
                      builder: (context, state) => Text(state == null
                          ? 0.toString()
                          : state.length.toString())),
                  IconButton(
                      icon: Icon(Icons.star),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Favorites()));
                      }),
                ],
              ),
            ],
            title: Text(
              "Filmes em Cartaz",
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
                  child: BlocBuilder<ListFilmesBloc, List<FilmeModel>>(
                      builder: (context, state) {
                    if (state == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.isEmpty) {
                      return Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context.bloc<ListFilmesBloc>().getMovies();
                            }),
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
                            BlocBuilder<FavoritesBloc, List<FilmeModel>>(
                                builder: (context, favoriteState) {
                              return IconButton(
                                  icon: Icon(
                                    context
                                            .bloc<FavoritesBloc>()
                                            .checkFavorito(state[index])
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    context
                                        .bloc<FavoritesBloc>()
                                        .setFavoritesMovies(state[index]);
                                    context.bloc<FavoritesBloc>().length;
                                    _showNotification(context);
                                  });
                            })
                          ],
                        ),
                      );
                    }
                  }),
                )
              ],
            ),
          )),
    );
  }

  void _showNotification(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text('Added to favorite'),
    ));
  }
}
