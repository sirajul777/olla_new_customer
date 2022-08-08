import 'dart:convert';
import 'package:customer/Service/API/api.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Pages/home.dart';
import 'package:customer/View/Router/dashboard.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAkun extends StatefulWidget {
  @override
  EditAkun({Key? key}) : super(key: key);
  State<EditAkun> createState() => _EditAkunState();
}

class _EditAkunState extends State<EditAkun> {
  List? data;
  bool loading = false;
  late String customer;
  Future getCustomer() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer')!;
    var response = await http.get(
        Uri.parse(
            Uri.encodeFull('https://olla.ws/api/customer/v1/customer-profile')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
          "Authorization": 'Bearer $customer',
        });

    if (response.statusCode == 200) {
      setState(() {
        var converDataToJson = json.decode(response.body);
        data = converDataToJson['data']['profile'];
      });
    }
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getCustomer().whenComplete(() => setState(() {
          loading = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.red,
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 60.0,
            ),
          ),
        ),
      );
    } else {
      final nameController = TextEditingController(text: data![0]['name']);
      final phoneController =
          TextEditingController(text: data![0]['mobile_phone']);
      final emailController = TextEditingController(text: data![0]['email']);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.blue[50],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
              ),
              GestureDetector(
                onTap: () {
                  // dataku();
                  getCustomer();
                },
                child: Text(
                  'Edit Akun',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'comfortaa',
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Nama Lengkap Anda",
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.only(), // add padding to adjust icon
                          child: Icon(
                            FeatherIcons.user,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: "Nomor Handphone",
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.only(), // add padding to adjust icon
                          child: Icon(
                            FeatherIcons.phone,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding:
                              EdgeInsets.only(), // add padding to adjust icon
                          child: Icon(
                            FeatherIcons.mail,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text('Simpan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text('Ganti Password'),
                        ),
                      ),
                    )
                  ])),
        ),
      );
    }
  }
}
