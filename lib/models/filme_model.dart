class FilmeModel {
  FilmeModel({
    this.data,
    this.genero,
    this.link,
    this.poster,
    this.sinopse,
    this.sinopseFull,
    this.titulo,
  });

  final String data;
  final String genero;
  final String link;
  final String poster;
  final String sinopse;
  final String sinopseFull;
  final String titulo;

  factory FilmeModel.fromMap(Map<String, dynamic> json) => FilmeModel(
        data: json["data"],
        genero: json["genero"],
        link: json["link"],
        poster: json["poster"],
        sinopse: json["sinopse"],
        sinopseFull: json["sinopseFull"],
        titulo: json["titulo"],
      );

  Map<String, dynamic> toMap() => {
        "data": data,
        "genero": genero,
        "link": link,
        "poster": poster,
        "sinopse": sinopse,
        "sinopseFull": sinopseFull,
        "titulo": titulo,
      };
}
