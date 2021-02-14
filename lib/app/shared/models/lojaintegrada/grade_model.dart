import '../base_model.dart';

class GradeModel extends BaseModel<GradeModel> {
  String idExterno;
  String nome;
  String nomeVisivel;

  GradeModel.fromMap(Map<dynamic, dynamic> map) : super('Grade') {
    baseFromMap(map);
    idExterno = map["id_externo"];
    nome = map["nome"];
    nomeVisivel = map["nome_visivel"];
  }

  toMap() {
    var map = super.toMap();
    map["id_externo"] = idExterno;
    map["nome"] = nome;
    map["nome_visivel"] = nomeVisivel;
    return map;
  }

  @override
  void updateData(GradeModel item) {}
}
