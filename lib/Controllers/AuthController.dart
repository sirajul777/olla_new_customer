import 'dart:convert';

import 'package:customer/Models/Auth.dart';
import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;

class AuthController {
  // AuthController(Auth initialState) : super(initialState);
  static Future<Auth> postLoginAuthToApi({required String email}) async {
    String myUrl = "https://olla.ws/api/customer/v1/login";
    var result = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      "x-token-olla": KEY.APIKEY,
      // "imei": "123456"
    }, body: {
      "email": email
    });
    var jsonObject = json.decode(result.body);

    // var Authdata = (jsonObject as Map<String, dynamic>)['data'];
    return Auth.login(jsonObject);

    // return Auth();
  }
}
