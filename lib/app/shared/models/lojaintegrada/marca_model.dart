import '../base_model.dart';

class MarcaModel extends BaseModel<MarcaModel> {
  String idExterno;
  String nome;
  String apelido;
  String descricao;

  MarcaModel.fromMap(Map<dynamic, dynamic> map) : super('Marca') {
    baseFromMap(map);
    idExterno = map["id_externo"];
    nome = map["nome"];
    apelido = map["apelido"];
    descricao = map["descricao"];
  }

  toMap() {
    var map = super.toMap();
    map["id_externo"] = idExterno;
    map["nome"] = nome;
    map["apelido"] = apelido;
    map["descricao"] = descricao;
    return map;
  }

  @override
  void updateData(MarcaModel item) {}
}
