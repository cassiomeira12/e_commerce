import '../base_model.dart';

class PrecoModel extends BaseModel<PrecoModel> {
  double cheio;
  double custo;
  double promocional;

  PrecoModel.fromMap(Map<dynamic, dynamic> map) : super('Preco') {
    baseFromMap(map);
    cheio = num.parse(map["cheio"]).toDouble();
    custo = num.parse(map["custo"]).toDouble();
    promocional = num.parse(map["promocional"]).toDouble();
  }

  toMap() {
    var map = super.toMap();
    map["cheio"] = cheio;
    map["custo"] = custo;
    map["promocional"] = promocional;
    return map;
  }

  @override
  void updateData(PrecoModel item) {}
}
