import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_on_board/api/api.dart';
import 'package:movies_on_board/blocs/favorites_bloc.dart';
import 'package:movies_on_board/blocs/listFilmes_bloc.dart';
import 'package:movies_on_board/services/shared_favoritos.dart';
import 'package:movies_on_board/screens/home_screen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => SharedFavoritos(),
        ),
        RepositoryProvider(
          create: (context) => Api(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ListFilmesBloc>(
              create: (context) => ListFilmesBloc(context.repository<Api>())),
          BlocProvider<FavoritesBloc>(
              lazy: false,
              create: (context) =>
                  FavoritesBloc(context.repository<SharedFavoritos>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        ),
      ),
    );
  }
}
