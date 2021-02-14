import '../base_model.dart';

class ProdutoModel extends BaseModel<ProdutoModel> {
  String idExterno;
  String sku;
  String mnp;
  String ncm;
  String nome;
  String descricaoCompleta;
  bool ativo;
  bool destaque;
  double peso;

  ProdutoModel.fromMap(Map<dynamic, dynamic> map) : super('Produto') {
    baseFromMap(map);
    idExterno = map["id_externo"];
    sku = map["sku"];
    mnp = map["mnp"];
    ncm = map["ncm"];
    nome = map["nome"];
    descricaoCompleta = map["descricao_completa"];
    ativo = map["ativo"] == 'true';
    destaque = map["destaque"] == 'true';
    peso = num.parse(map["peso"]).toDouble();
  }

  toMap() {
    var map = super.toMap();
    map["id_externo"] = idExterno;
    map["sku"] = sku;
    map["mnp"] = mnp;
    map["ncm"] = ncm;
    map["nome"] = nome;
    map["descricao_completa"] = descricaoCompleta;
    map["ativo"] = ativo;
    map["destaque"] = destaque;
    map["peso"] = peso;
    return map;
  }

  @override
  void updateData(ProdutoModel item) {}
}
