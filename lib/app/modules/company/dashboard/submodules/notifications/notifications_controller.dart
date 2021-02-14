import 'package:e_commerce/app/shared/repositories/parse/parse_company_service.dart';

class NotificationController {
  var respository = ParseCompanyService();
  list() {
    return respository.list();
  }
}
