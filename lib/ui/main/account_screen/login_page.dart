import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/account_bloc/login_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/check_phone_number.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/reset_pin_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
// import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
// import 'package:ma_laundry/ui/bloc/account_bloc/login_bloc.dart';
// import 'package:ma_laundry/ui/config/export_config.dart';
// import 'package:ma_laundry/utils/constant.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  User user = User();
  bool obScure = true;

  //deklarasi firebase messaging
  final _firebaseMessaging = FirebaseMessaging();

  //deklarasi local notification
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String teks = '';
  String get teksGetter => teks;
  var mymap = {};
  var title = '';
  var body = {};
  var mytoken = '';

  @override
  void initState() {
    super.initState();
    var android = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('on message $message');
      //jadikan mymap = message
      mymap = message;
      //tampilkan notifikasi
      displayNotifikasi(message);
    }, onResume: (Map<String, dynamic> message) {
      print('on resume $message');
    }, onLaunch: (Map<String, dynamic> message) {
      print('on launch $message');
    });

    _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      alert: true,
      badge: true,
    ));
    _firebaseMessaging.getToken().then((token) {
      updateToken(token);
      // print(token);
    });
  }

  displayNotifikasi(Map<String, dynamic> msg) async {
    var android =
    AndroidNotificationDetails("1", "channelName", "channelDescription");
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);

    msg.forEach((nTitle, nBody) {
      title = nTitle;
      body = nBody;
      setState(() {});
    });
    await flutterLocalNotificationsPlugin.show(
        0, msg['notification']['title'], msg['notification']['body'], platform);
  }

  updateToken(String token) {
    print(token);
    // var databaseReference = FirebaseDatabase().reference();
    // databaseReference.child('fcm-token/$token').set({"token": token});
    mytoken = token;
    user.firebaseToken = token;
    teks = mytoken;
    // pageList = [
    //   RequestJemputPage(),
    //   RequestAntarPage(),
    //   InboxPage(teks: teks),
    //   ProfilePage(),
    // ];
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => LoginBloc(context, scaffoldKey: _key))
      ],
      child: Consumer<LoginBloc>(
        builder: (context, blocLogin, _) => Scaffold(
          key: _key,
          body: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(normal)),
                    child: Container(
                      width: widthScreen(context),
                      padding: EdgeInsets.symmetric(
                          horizontal: medium, vertical: high),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              '$libImage/logo.png',
                              width: 180,
                            ),
                          ),
                          SizedBox(height: medium),
                          CustomTextField(
                            label: "Username",
                            onChanged: (value) {
                              user?.username = value;
                            },
                          ),
                          SizedBox(height: medium),
                          CustomTextField(
                            label: "PIN",
                            obscureText: obScure,
                            keyboardType: TextInputType.number,
                            suffixIcon: IconButton(
                              icon: Icon(obScure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() => obScure = !obScure);
                              },
                            ),
                            onChanged: (value) {
                              user?.pin = value;
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckPhoneNumberPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: normal),
                              alignment: Alignment.centerRight,
                              child: Text("Reset PIN",
                                  style: sansPro(fontSize: 13)),
                            ),
                          ),
                          blocLogin.isLoading
                              ? Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: medium),
                                  child: circularProgressIndicator(),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: medium),
                                      height: 45,
                                      width: widthScreen(context),
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(normal)),
                                        color: primaryColor,
                                        textColor: whiteNeutral,
                                        child: Text("Login"),
                                        onPressed: () {
                                          blocLogin.loginUser(user);
                                        },
                                      ),
                                    ),
                                    // Container(
                                    //   margin: EdgeInsets.only(top: medium),
                                    //   height: 45,
                                    //   width: widthScreen(context),
                                    //   child: RaisedButton(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(normal)),
                                    //     color: greyNeutral,
                                    //     child: Text("Register"),
                                    //     onPressed: () {},
                                    //   ),
                                    // ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
