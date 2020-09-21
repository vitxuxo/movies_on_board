import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_on_board/services/shared_favoritos.dart';
import 'package:movies_on_board/models/filme_model.dart';

class FavoritesBloc extends Cubit<List<FilmeModel>> {
  final SharedFavoritos favoritos;
  List<FilmeModel> favoritoSalvo;

  FavoritesBloc(this.favoritos) : super(null) {
    getFavoritesMovies();
  }

  Future<void> getFavoritesMovies() async {
    List<FilmeModel> listAux = await favoritos.getFavoritos();
    if (listAux == null) {
      this.favoritoSalvo = <FilmeModel>[];
    } else {
      this.favoritoSalvo = List<FilmeModel>.from(listAux);
    }
    emit(this.favoritoSalvo);
  }

  Future<void> setFavoritesMovies(FilmeModel filme) async {
    if (this.favoritoSalvo == null) {
      this.favoritoSalvo = <FilmeModel>[];
    }
    if (this.favoritoSalvo.length < 3 && !this.favoritoSalvo.contains(filme)) {
      this.favoritoSalvo.add(filme);
    } else {
      this.removeFavorite(filme);
    }
    this.atualizarLista();
  }

  Future<void> removeFavorite(FilmeModel filme) async {
    this.favoritoSalvo.remove(filme);
    this.atualizarLista();
  }

  bool checkFavorito(FilmeModel filme) {
    return this.favoritoSalvo.contains(filme);
  }

  Future<void> atualizarLista() async {
    this.favoritoSalvo = List<FilmeModel>.from(this.favoritoSalvo);
    emit(favoritoSalvo);
    await favoritos.salvarFavoritos(favoritoSalvo);
  }
}
