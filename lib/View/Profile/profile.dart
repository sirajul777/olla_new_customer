import 'package:customer/View/Auth/Login/landingAuth.dart';
import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Profile/edit_akun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      return Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.w),
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                image: AssetImage('gambar/gambarprofile.png'),
              )),
            ),
            Center(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${nama} !',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Customer -',
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: darkGrey),
                      ),
                      //
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Member Gold',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 12, color: darkGrey),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.blue[50]!)),
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
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkGrey),
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
                          leading: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(color: darkYellow, borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 22,
                                color: white,
                              )),
                          title: Text(
                            'Nominal',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          subtitle: Text(
                            'Rp 0',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
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
            Container(
              margin: EdgeInsets.only(left: 30.w, right: 20.w),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0, top: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) => EditAkun()))
                          .then((value) => setState(() {}));
                    },
                    child: Container(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: lightBlue, borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Icon(
                            Icons.person_outline,
                            color: Color.fromARGB(255, 59, 167, 255),
                          )),
                        ),
                        title: Text(
                          'Edit Akun',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: darkGrey),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: softGrey,
                          size: 11,
                        ),
                      ),
                    ),
                  ),
                ),
                //
                Container(
                  child: Container(
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: lightBlue, borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Icon(
                          Icons.settings_outlined,
                          color: Color.fromARGB(255, 59, 167, 255),
                        )),
                      ),
                      title: Text(
                        'Pengaturan Aplikasi',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: darkGrey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: softGrey,
                        size: 11,
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Container(
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: lightBlue, borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Icon(
                          Icons.info_outline,
                          color: Color.fromARGB(255, 59, 167, 255),
                        )),
                      ),
                      title: Text(
                        'Syarat dan Ketentuan Aplikasi',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: darkGrey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: softGrey,
                        size: 11,
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Container(
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: lightBlue, borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Icon(
                          Icons.help_outline,
                          color: Color.fromARGB(255, 59, 167, 255),
                        )),
                      ),
                      title: Text(
                        'Bantuan',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: darkGrey),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: softGrey,
                        size: 11,
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
                    padding: const EdgeInsets.only(top: 2),
                    child: Container(
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: lightBlue, borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Icon(
                            Icons.logout_outlined,
                            color: Color.fromARGB(255, 59, 167, 255),
                          )),
                        ),
                        title: Text(
                          'Keluar',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: darkGrey),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: softGrey,
                          size: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )

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
  }

  @override
  bool loading = false;
  void initState() {
    super.initState();
    Getgambar().whenComplete(() => setState(() {
          loading = true;
        }));
  }

  void out() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('sukses');
  }

  //
  late String nama;
  Future Getgambar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = (prefs.getString('nama')!);
    });
  }
}
