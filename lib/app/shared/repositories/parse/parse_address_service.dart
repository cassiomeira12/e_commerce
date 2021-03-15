import 'base_parse_service.dart';

class ParseAddressService {
  var service = BaseParseService('Address');

  Future create(item) async {
    return service.create(item);
  }

  Future read(item) async {
    return service.read(item);
  }

  Future update(item) async {
    return service.update(item);
  }

  Future delete(item) async {
    return service.delete(item);
  }

  Future findBy(String field, value) async {
    return service.findBy(field, value);
  }

  Future list() {
    return service.list();
  }
}
