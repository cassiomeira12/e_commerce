import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';

class ContactController extends GetxController {
  sendContact({name, phoneNumber, subject, message}) async {
    var dio = Dio();
    var response = await dio.post(
      "${GlobalConfiguration().appConfig['SERVER_URL']}/classes/Contact",
      options: Options(
        headers: {
          'X-Parse-Application-Id': GlobalConfiguration().appConfig['APP_ID'],
          'X-Parse-REST-API-Key':
              GlobalConfiguration().appConfig['REST_API_KEY'],
        },
      ),
      data: {
        'name': name,
        'phoneNumber': phoneNumber,
        'subject': subject,
        'message': message,
      },
    );
    return response.data;
  }
}
