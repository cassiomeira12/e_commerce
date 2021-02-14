import 'package:e_commerce/app/shared/repositories/parse/base_parse_service.dart';

class ParsePlanService {
  var service = BaseParseService('Plan');

  listPlans() async {
    // var dio = Dio();
    // var response = await dio.post(
    //   "${ParseInit.serverUrl}functions/plans",
    //   options: Options(
    //     headers: {
    //       'X-Parse-Application-Id': ParseInit.appId,
    //       'X-Parse-REST-API-Key': ParseInit.restApiKet,
    //     },
    //   ),
    // );
    // return response.data['result'];
  }
}
