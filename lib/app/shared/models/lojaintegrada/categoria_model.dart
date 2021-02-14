import '../base_model.dart';

class CategoriaModel extends BaseModel<CategoriaModel> {
  String idExterno;
  String nome;
  String descricao;
  String categoriaPai;

  CategoriaModel.fromMap(Map<dynamic, dynamic> map) : super('Categoria') {
    baseFromMap(map);
    idExterno = map["id_externo"];
    nome = map["nome"];
    descricao = map["descricao"];
    categoriaPai = map["categoriaPai"];
  }

  toMap() {
    var map = super.toMap();
    map["id_externo"] = idExterno;
    map["nome"] = nome;
    map["descricao"] = descricao;
    map["categoria_pai"] = categoriaPai;
    return map;
  }

  @override
  void updateData(CategoriaModel item) {}
}
