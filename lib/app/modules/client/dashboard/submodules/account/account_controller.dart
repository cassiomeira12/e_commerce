import 'package:e_commerce/app/shared/repositories/parse/parse_user_service.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var service = ParseUserService();

  Future updateUserData(user) async {
    return service.update(user.toMap());
  }

  Future updateAvatarURL() async {
    //
  }
}
