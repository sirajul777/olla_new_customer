import 'package:customer/View/Components/appProperties.dart';
import 'package:customer/View/Home/keranjang.dart';
import 'package:customer/View/Pages/Inbox.dart';
import 'package:customer/View/Pages/home.dart';
import 'package:customer/View/TabDashboard/profile.dart';
import 'package:customer/View/Pages/transaski.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentTab = 0;
  final List<Widget> screens = [
    Home(
      auto: '',
    ),
    Inbox(),
    Transaski(),
    Profile(),
    Keranjang()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home(
    auto: 'gome',
  );
  // int _selectedIndex = 0;
  // PageController pageController = PageController();
  // final tabs = [
  // //  TabHome(),
  // Home(),
  //  //
  //  //untuk wallet
  //   // TabWallet(),
  //   Home(),
  //   Home(),
  //   Home(),
  //   Home(),
  //           //
  //           //untuk history
  //   // Tab_History(),
  //           //
  //           //untuk setting
  // //  TabSetting(),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBack(
        message: "Tekan lagi untuk keluar",
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Icon(
            Icons.local_mall,
            color: white,
          ),
        ),
        onPressed: () {
          setState(() {
            setState(() {
              currentScreen = Keranjang();
              currentTab = 0;
            });
          });
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Home(
                          auto: '',
                        );
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Icon(
                              Icons.home_outlined,
                              color: currentTab == 0 ? primary : softGrey,
                            )),
                        Text(
                          'Home',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Inbox();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            Icons.forward_to_inbox,
                            color: currentTab == 1 ? primary : softGrey,
                          ),
                        ),
                        Text(
                          'Inbox',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //
                ],
              ),
              //
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Transaski();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            Icons.description_outlined,
                            color: currentTab == 2 ? primary : softGrey,
                          ),
                        ),
                        Text(
                          'Transaksi',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            Icons.supervisor_account_outlined,
                            color: currentTab == 3 ? primary : softGrey,
                          ),
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //
                ],
              ),
            ],
          ),
        ),
      ),
      //   body: tabs[
      //     _selectedIndex
      //   ],
      //   // PageView(
      //   //   controller: pageController,
      //   // ),
      //   bottomNavigationBar: BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem( icon:Icon(Icons.home),label:'home'),
      //       BottomNavigationBarItem( icon:Icon(Icons.map),label:'wallet'),
      //       BottomNavigationBarItem(icon:Icon(Icons.shopping_basket),label:'history'),
      //       BottomNavigationBarItem(icon:Icon(Icons.email),label:'setting'),
      //       BottomNavigationBarItem(icon:Icon(Icons.people),label:'setting'),
      //     ],
      //     onTap: (index){
      //       setState(() {
      //         _selectedIndex = index;
      //       });
      //     },

      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: _selectedIndex,
      //     backgroundColor: Colors.grey[100],
      //     selectedItemColor: Colors.grey[500],
      //     unselectedItemColor: Colors.grey[350],
      //   ),
    );
  }

  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }
}
