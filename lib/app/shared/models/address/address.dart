import '../base_model.dart';

class Address extends BaseModel<Address> {
  String bairro;
  String cep;
  String cidade;
  String clienteURI = "/api/v1/cliente/103265/";
  String complemento;
  String endereco;
  String estado;
  String nome;
  String numero;
  String pais;
  bool principal = true;
  String referencia;
  String resourceURI = "/api/v1/endereco/102512/";

  Address() : super('Address');

  Address.fromMap(Map<dynamic, dynamic> map) : super('Address') {
    baseFromMap(map);
    bairro = map['bairro'];
    cep = map['cep'];
    cidade = map['cidade'];
    clienteURI = map['cliente'];
    complemento = map['complemento'];
    endereco = map['endereco'];
    estado = map['estado'];
    nome = map['nome'];
    numero = map['numero'];
    pais = map['pais'];
    principal = map['principal'];
    referencia = map['referencia'];
    resourceURI = map['resource_uri'];
  }

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map['bairro'] = bairro;
    map['cep'] = cep;
    map['cidade'] = cidade;
    map['cliente'] = clienteURI;
    map['complemento'] = complemento;
    map['endereco'] = endereco;
    map['estado'] = estado;
    map['nome'] = nome;
    map['numero'] = numero;
    map['pais'] = pais;
    map['principal'] = principal;
    map['referencia'] = referencia;
    map['resource_uri'] = resourceURI;
    return map;
  }

  @override
  updateData(Address item) {
    id = item.id;
    objectId = item.objectId;
    createdAt = item.createdAt;
    updatedAt = item.updatedAt;

    bairro = item.bairro;
    cep = item.cep;
    cidade = item.cidade;
    clienteURI = item.clienteURI;
    complemento = item.complemento;
    endereco = item.endereco;
    estado = item.estado;
    nome = item.nome;
    numero = item.numero;
    pais = item.pais;
    principal = item.principal;
    referencia = item.referencia;
    resourceURI = item.resourceURI;
  }

  @override
  String toString() {
    return "$endereco, $numero, $complemento, $cidade-$estado $cep";
  }
}
