import '../base_model.dart';

class EstoqueModel extends BaseModel<EstoqueModel> {
  bool gerenciado;
  int situacaoEmEstoque;
  int situacaoSemEstoque;
  int quantidade;

  EstoqueModel.fromMap(Map<dynamic, dynamic> map) : super('Estoque') {
    baseFromMap(map);
    gerenciado = map["gerenciado"] == 'true';
    situacaoEmEstoque = num.parse(map["situacao_em_estoque"]).toInt();
    situacaoSemEstoque = num.parse(map["situacao_sem_estoque"]).toInt();
    quantidade = num.parse(map["quantidade"]).toInt();
  }

  toMap() {
    var map = super.toMap();
    map["gerenciado"] = gerenciado;
    map["situacao_em_estoque"] = situacaoEmEstoque;
    map["situacao_sem_estoque"] = situacaoSemEstoque;
    map["quantidade"] = quantidade;
    return map;
  }

  @override
  void updateData(EstoqueModel item) {}
}
