import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:e_commerce/app/shared/repositories/parse/parse_login_service.dart';
import 'package:get/get.dart';

class LoginController {
  var loginService = ParseLoginService();
  var auth = Get.find<AuthService>();

  signIn(email, password) async {
    var result = await loginService.signIn(email, password);
    await auth.currentUser();
    if (!auth.isAuth()) {
      throw Exception("Usuário não encontrado");
    }
    return result;
  }

  signInWithGoogle() async {
    var result = await loginService.signInWithGoogle();
    await auth.currentUser();
    if (!auth.isAuth()) {
      throw Exception("Usuário não encontrado");
    }
    return result;
  }

  signAnonymous() {
    loginService.signAnonymous();
  }
}
