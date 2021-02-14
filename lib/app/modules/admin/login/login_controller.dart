import 'package:e_commerce/app/shared/repositories/admin_service.dart';
import 'package:e_commerce/app/shared/repositories/parse/parse_login_service.dart';
import 'package:e_commerce/app/utils/strings/errors.dart';
import 'package:get/get.dart';

class LoginController {
  var loginService = ParseLoginService();
  var admin = Get.put(AdminService());

  signIn(email, password) async {
    var result = await loginService.signIn(email, password);
    await admin.currentAdminUser();
    if (!admin.isAdmin()) {
      throw Exception(ERROR_LOGIN_PASSWORD);
    }
    return result;
  }

  signInWithGoogle() async {
    var result = await loginService.signInWithGoogle();
    await admin.currentAdminUser();
    if (!admin.isAdmin()) {
      throw Exception(ERROR_LOGIN_PASSWORD);
    }
    return result;
  }

  signAnonymous() async {
    //return loginService.signAnonymous();
  }
}
