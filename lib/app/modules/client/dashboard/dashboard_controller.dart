import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:e_commerce/app/shared/repositories/auth_service.dart';
import 'package:e_commerce/app/shared/repositories/parse/parse_version_app_service.dart';
import 'package:e_commerce/app/utils/strings/strings.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  var versionAppService = ParseVersionAppService();

  Future<dynamic> versionApps;

  var auth = Get.find<AuthService>();

  signOut(context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: CLOSE,
      okLabel: CLOSE,
      cancelLabel: CANCEL,
      message: "Deseja sair do $APP_NAME ?",
    );
    switch (result) {
      case OkCancelResult.ok:
        var logout = await auth.logout();
        if (logout) {
          return Get.offNamed('/client');
        }
        return;
      case OkCancelResult.cancel:
        return;
    }
  }

  updateVersionApp(item) {
    return versionAppService.update(item);
  }

  listVersionApps() {
    //if (versionApps == null) {
    versionApps = versionAppService.list();
    //}
    return versionApps;
  }
}
