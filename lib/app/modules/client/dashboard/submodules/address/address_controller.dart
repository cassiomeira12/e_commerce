import 'package:e_commerce/app/shared/models/address/address.dart';
import 'package:e_commerce/app/shared/repositories/parse/parse_address_service.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  var service = ParseAddressService();

  Future create(item) {
    return service.create(item.toMap());
  }

  Future updateItem(item) {
    return service.update(item.toMap());
  }

  Future list() {
    return service.list().then((value) {
      return value.map((e) => Address.fromMap(e)).toList();
    });
  }
}
