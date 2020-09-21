import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_on_board/api/api.dart';
import 'package:movies_on_board/models/filme_model.dart';

class ListFilmesBloc extends Cubit<List<FilmeModel>> {
  final Api api;
  ListFilmesBloc(this.api) : super(null) {
    getMovies();
  }

  Future<void> getMovies() async {
    try {
      List<FilmeModel> listaMovies = await api.showMovies();
      emit(listaMovies);
    } catch (e) {
      emit(<FilmeModel>[]);
    }
  }
}
