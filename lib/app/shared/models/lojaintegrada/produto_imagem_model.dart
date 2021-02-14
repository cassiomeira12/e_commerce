import '../base_model.dart';

class ProdutoImagemModel extends BaseModel<ProdutoImagemModel> {
  String imagemUrl;
  String produto;
  bool principal;
  int posicao;
  String mime;

  ProdutoImagemModel.fromMap(Map<dynamic, dynamic> map)
      : super('ProdutoImagem') {
    baseFromMap(map);
    imagemUrl = map["imagem_url"];
    produto = map["produto"];
    principal = map["principal"] == 'true';
    posicao = num.parse(map["posicao"]).toInt();
    mime = map["mime"];
  }

  toMap() {
    var map = super.toMap();
    map["imagem_url"] = imagemUrl;
    map["produto"] = produto;
    map["principal"] = principal;
    map["posicao"] = posicao;
    map["mime"] = mime;
    return map;
  }

  @override
  void updateData(ProdutoImagemModel item) {}
}
