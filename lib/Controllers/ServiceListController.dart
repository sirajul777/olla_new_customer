import 'dart:convert';

import 'package:customer/Models/ServisList.dart';
import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;

class ServisListController {
  static Future<ServisList> getAppsService() async {
    String url = 'https://olla.ws/api/customer/v1/service-list';
    var result = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      "x-token-olla": KEY.APIKEY,
      // "imei": "123456"
    });
    var jsonObject = json.decode(result.body);

    // var Authdata = (jsonObject as Map<String, dynamic>)['data'];
    return ServisList.fromJson(jsonObject);
  }
}
