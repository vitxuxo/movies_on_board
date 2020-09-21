import 'dart:convert';

import 'package:movies_on_board/models/filme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedFavoritos {
  Future<SharedPreferences> favoritesMovies = SharedPreferences.getInstance();

  Future<void> salvarFavoritos(List<FilmeModel> favoritosSalvo) async {
    SharedPreferences sharedPreferences = await this.favoritesMovies;
    List<Map> favList =
        favoritosSalvo.map((favorite) => favorite.toMap()).toList();
    String favorito = json.encode(favList);
    sharedPreferences.setString('favList', favorito);
  }

  Future<List<FilmeModel>> getFavoritos() async {
    SharedPreferences sharedPreferences = await this.favoritesMovies;
    String favList = sharedPreferences.getString('favList');
    if (favList != null) {
      List favListCheck = json.decode(favList);
      List<FilmeModel> favoritos = favListCheck
          .map((filmeFavorito) => FilmeModel.fromMap(filmeFavorito))
          .toList();
      return (favoritos);
    } else {
      return null;
    }
  }
}
