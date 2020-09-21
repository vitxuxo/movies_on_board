import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_on_board/models/filme_model.dart';

class Api {
  Future<List<FilmeModel>> showMovies() async {
    http.Response movies =
        await http.get("https://filmespy.herokuapp.com/api/v1/filmes");
    if (movies.statusCode == 200) {
      Map moviesDecoded = json.decode(movies.body);
      List moviesDecodedList = moviesDecoded["filmes"];
      List<FilmeModel> listaFilmeModel =
          moviesDecodedList.map((filme) => FilmeModel.fromMap(filme)).toList();
      return listaFilmeModel;
    } else {
      return null;
    }
  }
}
