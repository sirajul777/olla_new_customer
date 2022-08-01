import 'package:customer/View/Components/Transaksi/batal.dart';
import 'package:customer/View/Components/Transaksi/berhasil.dart';
import 'package:customer/View/Components/Transaksi/proses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transaski extends StatefulWidget {
  @override
  State<Transaski> createState() => _TransaskiState();
}

class _TransaskiState extends State<Transaski> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getDataorder();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        loading = true;
      });
    });
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  late String customer;
  Future getDataorder() async {
    final prefs1 = await SharedPreferences.getInstance();
    setState(() {
      customer = prefs1.getString('customer')!;
    });
  }

  bool loading = false;
  //
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
      // TabController _tabController = TabController(length: 3, vsync: this);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              // print(datalist);
            },
            child: Text(
              "Transaksi",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'comfortaa',
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.transparent,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          // bottom: TabBar(
          //   tabs:[
          //     Tab(text:'Proses',),
          //     Tab(text:'Berhasil'),
          //     Tab(text:'Batal',),
          //   ]
          // ),
        ),
        body: ListView(
          clipBehavior: Clip.none,
          children: [
            Container(
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.white,
                tabs: [
                  Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _tabController.index == 0 ? Colors.blue : Colors.grey)),
                      child: Tab(
                        text: 'Proses',
                      )),
                  //
                  Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _tabController.index == 1 ? Colors.blue : Colors.grey)),
                      child: Tab(
                        text: 'Berhasil',
                      )),
                  //
                  Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _tabController.index == 2 ? Colors.blue : Colors.grey)),
                      child: Tab(
                        text: 'Batal',
                      )),
                ],
              ),
            ),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Proses(
                    customer: customer,
                  ),
                  Berhasil(),
                  Batal(),
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
