import 'package:customer/View/TabDashboard/batal.dart';
import 'package:customer/View/TabDashboard/berhasil.dart';
import 'package:customer/View/TabDashboard/proses.dart';
import 'package:flutter/material.dart';

class Transaski extends StatefulWidget {
  @override
  State<Transaski> createState() => _TransaskiState();
}

class _TransaskiState extends State<Transaski>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
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
                        border: Border.all(
                            color: _tabController.index == 0
                                ? Colors.blue
                                : Colors.grey)),
                    child: Tab(
                      text: 'Proses',
                    )),
                //
                Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _tabController.index == 1
                                ? Colors.blue
                                : Colors.grey)),
                    child: Tab(
                      text: 'Berhasil',
                    )),
                //
                Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: _tabController.index == 2
                                ? Colors.blue
                                : Colors.grey)),
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
                Proses(),
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