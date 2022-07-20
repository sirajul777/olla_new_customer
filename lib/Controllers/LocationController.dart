import 'dart:convert';

import 'package:customer/Models/Lokasi.dart';
import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LocationController {
  static Future<GetLokasi> getLokasiBaru() async {
    late String secreat_code;
    final prefs1 = await SharedPreferences.getInstance();
    secreat_code = prefs1.getString('customer')!;
    String myUrl = KEY.BASE_URL + '/address';
    var result = await http.get(
      Uri.parse(myUrl),
      headers: {
        'Accept': 'application/json',
        "x-token-olla": KEY.APIKEY,
        "Authorization": 'Bearer ${secreat_code}',

        // "imei": "123456"
      },
    );
    // print(result.body);

    var jsonObject2 = json.decode(result.body);
    // print(jsonObject2);

    return GetLokasi.getLoc(jsonObject2);

    // return Auth();
  }

  static Future<Lokasi> PostLokasiBaru({required var body, required String bearer}) async {
    var result = await http.post(Uri.parse(Uri.encodeFull(KEY.BASE_URL + "/address")),
        headers: {
          'Accept': 'application/json',
          "x-token-olla": KEY.APIKEY,
          "Authorization": 'Bearer ${bearer}',
          'Content-type': 'application/json'
          // "imei": "123456"
        },
        body: body);

    // var jsonObject = json.encode(result);
    var jsonObject2 = json.decode(result.body);
    print(jsonObject2);
    // var Authdata = (jsonObject as Map<String, dynamic>)['data'];
    return Lokasi.post(jsonObject2);
    // return Auth();
  }
}
