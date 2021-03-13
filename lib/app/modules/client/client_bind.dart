import 'package:get/get.dart';

import 'client_controller.dart';

class ClientBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(() => ClientController());
  }
}
