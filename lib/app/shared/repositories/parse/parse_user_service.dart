import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'base_parse_service.dart';

class ParseUserService {
  var service = BaseParseService('_User');

  Future create(item) async {
    return service.create(item);
  }

  read(item) async {
    return service.read(item);
  }

  Future update(item) async {
    return service.update(item).then((value) async {
      var parseUser = await ParseUser.currentUser();
      await parseUser.getUpdatedUser();
      return value;
    });
  }

  delete(item) async {
    return service.delete(item);
  }

  findBy(String field, value) async {
    return service.findBy(field, value);
  }

  list() {
    return service.list();
  }
}
