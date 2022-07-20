import 'dart:convert';

import 'package:customer/Models/User.dart';
import 'package:customer/Service/API/api.dart';
import 'package:http/http.dart' as http;

class UserController {
  // get users
  // static Future<User> getUserFromApi(int id) async {
  //   var result = await http.get(Uri.parse(KEY.BASE_URL));
  //   var jsonObject = json.decode(result.body);
  //   var userdata = (jsonObject as Map<String, dynamic>)['data'];
  //   return User.getUser(userdata);
  // }

  // create user
  static Future<User> postCreateUserToApi(String name) async {
    var result = await http.post(Uri.parse(KEY.BASE_URL + "/register"), body: {name: name});
    var jsonObject = json.decode(result.body);
    var userdata = (jsonObject as Map<String, dynamic>)['data'];
    User.createUser(userdata);

    return User();
  }

  // update user
  // static Future<User> putUpdateUserToApi(String name) async {
  //   var result = await http.post(Uri.parse(KEY.BASE_URL), body: {name: name});
  //   var jsonObject = json.decode(result.body);
  //   var userdata = (jsonObject as Map<String, dynamic>)['data'];
  //   return User.updateUser(userdata);
  // }

  // logout user
  // static Future<User> logoutUserToApi(String name) async {
  //   var result = await http.post(Uri.parse(KEY.BASE_URL), body: {name: name});
  //   var jsonObject = json.decode(result.body);
  //   var userdata = (jsonObject as Map<String, dynamic>)['data'];
  //   return User.logoutUser(userdata);
  // }
}
