import 'base_parse_service.dart';

class ParseCountryService {
  var _service = BaseParseService("Country");

  Future<dynamic> create(dynamic item) async {
    return _service.create(item);
  }

  Future<dynamic> read(dynamic item) {
    return _service.read(item);
  }

  Future<dynamic> update(dynamic item) {
    return _service.update(item);
  }

  Future<dynamic> delete(dynamic item) {
    return _service.delete(item);
  }

  Future<List<dynamic>> findBy(String field, value) async {
    return _service.findBy(field, value);
  }

  Future<List<dynamic>> list() {
    return _service.list();
  }
}
