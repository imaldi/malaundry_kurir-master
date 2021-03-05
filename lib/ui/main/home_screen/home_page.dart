import 'dart:developer';

import 'package:flutter/material.dart';
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
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      mainPageController.animateTo(_selectedIndex);
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Pick Up',
      // style: optionStyle,
    ),
    Text(
      'Antar',
      // style: optionStyle,
    ),
    // Text(
    //   'Inbox',
    //   // style: optionStyle,
    // ),
    Text(
      'Profil',
      // style: optionStyle,
    ),
  ];

  var _selectedIndex = 0;
  var pageList
      // = [];
      = [
    RequestJemputPage(),
    RequestAntarPage(),
    // InboxPage(),
    ProfilePage(),
  ];

  handleDataNotif(String menu) {
    setState(() {
      if (menu.contains("jemput")) {
        mainPageController.animateTo(0);
        _selectedIndex = 0;
        // titleMenu = listNameMenu[6];
      }
      if (menu.contains("antar")) {
        mainPageController.animateTo(1);
        _selectedIndex = 1;
        // titleMenu = listNameMenu[7];
      }
    });
  }
  @override
  void initState() {
    super.initState();
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
        builder: (context, notifBloc, _) => Scaffold(
          // drawer: DrawerHome(
          //   listNameMenu: listNameMenu,
          //   controller: mainPageController,
          // ),
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
    children: pageList.map((e) => e).toList(),),
          // Container(
          //   child: Center(
          //     child: _widgetOptions[_selectedIndex],
          //     // Text("Ini HomeScreen"),
          //   ),
          // ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
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
        ),
      ),
    );
  }
}
