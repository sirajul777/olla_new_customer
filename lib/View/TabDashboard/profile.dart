import 'package:customer/View/Auth/Login/landingAuth.dart';
import 'package:customer/View/TabDashboard/edit_akun.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
              image: AssetImage('gambar/gambarprofile.png'),
            )),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${nama} !',
                        style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Customer -',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                          //
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Member Gold',
                            style: TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blue[50]!)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Saldo Saya',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Riwayat',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        minVerticalPadding: 20,
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('gambar/rupiah.png'),
                          radius: 20,
                        ),
                        title: Text(
                          'Nominal',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        subtitle: Text(
                          'Rp 320.000',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40, top: 13),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Text(
                                'Cairkan',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0, top: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditAkun()));
              },
              child: Container(
                child: ListTile(
                  leading: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('gambar/edit.png'),
                      ),
                    ),
                  ),
                  title: Text(
                    'Edit Akun',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              child: ListTile(
                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('gambar/atur.png'),
                    ),
                  ),
                ),
                title: Text(
                  'Pengaturan Aplikasi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              child: ListTile(
                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('gambar/syarat.png'),
                    ),
                  ),
                ),
                title: Text(
                  'Syarat dan Ketentuan Aplikasi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          //
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              child: ListTile(
                leading: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('gambar/bantuan.png'),
                    ),
                  ),
                ),
                title: Text(
                  'Bantuan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          //
          GestureDetector(
            onTap: () {
              SweetAlert.show(context,
                  subtitle: "Apakah Anda Yakin Keluar ?",
                  cancelButtonText: 'Tidak',
                  confirmButtonText: 'Ya',
                  style: SweetAlertStyle.confirm,
                  showCancelButton: true, onPress: (bool isConfirm) {
                if (isConfirm) {
                  // SweetAlert.show(context, style: SweetAlertStyle.loading,subtitle: 'Loading...');
                  SweetAlert.show(context, style: SweetAlertStyle.success);

                  new Future.delayed(new Duration(seconds: 2), () {
                    out();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => LandingAuth()),
                        (Route<dynamic> route) => true);

                    //  Navigator.pushAndRemoveUntil(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (BuildContext context) => HomeSlide()),
                    //                 (Route<dynamic> route) => false);
                  });
                } else {
                  SweetAlert.show(
                    context,
                    subtitle: "Cancel!",
                    style: SweetAlertStyle.error,
                  );
                }
                // return false to keep dialog
                return false;
              });
            },

            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.remove('sukses');
            //  Navigator.pushAndRemoveUntil(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (BuildContext context) => HomeSlide()),
            //                 (Route<dynamic> route) => false);

            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                child: ListTile(
                  leading: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('gambar/keluar.png'),
                      ),
                    ),
                  ),
                  title: Text(
                    'Keluar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          //

          //
        ],
      ),
      // Center(
      //   child: GestureDetector(
      //     onTap: () async {
      //        SharedPreferences prefs =
      //                               await SharedPreferences.getInstance();
      //                           prefs.remove('sukses');
      //                             Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => HomeSlide(),
      //   ),
      // );
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.only(left:20.0,right: 20),
      //       child: Container(
      //         height: 50,
      //         color: Colors.blue,
      //         child: Center(child: Text('LogOut'))),
      //     )),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    Getgambar();
  }

  void out() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('sukses');
  }

  //
  late String nama;
  void Getgambar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = (prefs.getString('nama')!);
    });
  }
}
