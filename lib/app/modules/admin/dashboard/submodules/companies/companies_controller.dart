import 'package:e_commerce/app/shared/repositories/parse/parse_company_service.dart';

class CompaniesController {
  var repository = ParseCompanyService();

  list() {
    return repository.list();
  }
}
