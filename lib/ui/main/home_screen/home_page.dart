import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malaundry_kurir_flutter/ui/config/colors.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/profile_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/notification_screen/notification_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/request_antar_screen/request_antar_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/request_jemput_screen/request_jemput_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:malaundry_kurir_flutter/utils/notification_handler.dart';
import 'package:provider/provider.dart';

TabController mainPageController;

class HomePage extends StatefulWidget {
  // final int pageIndex;
  // final int idAntar;
  // final int idJemput;
  // HomePage({this.pageIndex, this.idJemput, this.idAntar});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // int get _pageIndex => widget.pageIndex;
  NotificationHandler notificationHandler;
  void _onItemTapped(int index) {
    setState(() {
      // _selectedIndex = index;
      notificationHandler.pageIndex = index;
      mainPageController.animateTo(_selectedIndex);
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Pick Up',
    ),
    Text(
      'Antar',
    ),
    Text(
      'Profil',
    ),
  ];

  var _selectedIndex = 0;
  var pageList
      = <Widget>[];
  //     = [
  //   RequestJemputPage(),
  //   RequestAntarPage(),
  //   ProfilePage(),
  // ];

  handleDataNotif(String menu) {
    setState(() {
      if (menu.contains("jemput")) {

        notificationHandler.pageIndex = 0;
        mainPageController.animateTo(0);
        // _selectedIndex = 0;
        // titleMenu = listNameMenu[6];
      }
      if (menu.contains("antar")) {

        notificationHandler.pageIndex = 1;
        mainPageController.animateTo(1);
        // _selectedIndex = 1;
        // titleMenu = listNameMenu[7];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // if (_pageIndex != null) {
    //   Fluttertoast.showToast(
    //     msg: "Page Index From Notif : $_pageIndex",
    //     // "\nNotif Content : ${listNotif[0].body}",
    //     //     "\norderType : ${ listNotif[0].body.contains("Pick up") ? "Jemput" : "Antar"}",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,);
    //   _selectedIndex = _pageIndex;
    // }
    pageList = [
      RequestJemputPage(),
      RequestAntarPage(),
      // InboxPage(),
      ProfilePage(),
    ];
    mainPageController = TabController(length: pageList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => NotificationHandler(context))
      ],
      child: Consumer<NotificationHandler>(
        builder: (context, notifBloc, _) {
          // notifBloc.pageIndex == 0 ? _selectedIndex = 0: _selectedIndex = 1 ;
          _selectedIndex = notifBloc.pageIndex;
          mainPageController.animateTo(_selectedIndex);
          notificationHandler = notifBloc;
          return Scaffold(
          appBar: AppBar(
            title: _widgetOptions[_selectedIndex],
            actions: [
              IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.notifications),
                    CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.red,
                      child: Text(
                        "${notifBloc.listNotif.length}",
                        style: sansPro(
                          color: whiteNeutral,
                          fontSize: 7,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  navigateTo(context, NotificationPage(notif: notifBloc))
                      .then((value) {
                    log("Res $value");
                    String data =
                        value.toString().replaceAll(RegExp(r'[/,_]'), "");
                    handleDataNotif(data.toLowerCase());
                  });
                },
              )
            ],
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: mainPageController,
            children: pageList.map((e) => e).toList(),
          ),
          // Container(
          //   child: Center(
          //     child: _widgetOptions[_selectedIndex],
          //     // Text("Ini HomeScreen"),
          //   ),
          // ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: notifBloc.pageIndex,
              // _selectedIndex,
              selectedItemColor: primaryColor,
              // unselectedIconTheme: IconThemeData(color: Colors.grey),
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              onTap: _onItemTapped,
              // backgroundColor: Colors.blueGrey,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.file_download,
                    ),
                    label: "Pickup"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.file_upload), label: "Hantar"),
                // BottomNavigationBarItem(icon: Icon(Icons.email_outlined),label: "Inbox"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "Profile")
              ]),
          // TabBarView(
          //   physics: NeverScrollableScrollPhysics(),
          //   controller: mainPageController,
          //   children: listMenu.map((e) => e).toList(),
          // ),
        );
        },
      ),
    );
  }
}
