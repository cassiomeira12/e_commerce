import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';

class NewsletterController extends GetxController {
  sendNewsletter({email, firstname, lastname, phonenumber}) async {
    var dio = Dio();
    var response = await dio.post(
      "${GlobalConfiguration().appConfig['SERVER_URL']}/functions/newsletter",
      options: Options(
        headers: {
          'X-Parse-Application-Id': GlobalConfiguration().appConfig['APP_ID'],
          'X-Parse-REST-API-Key':
              GlobalConfiguration().appConfig['REST_API_KEY'],
        },
      ),
      data: {
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'sms': phonenumber,
      },
    );
    return response.data['result'];
  }
}
