import 'dart:developer';
import 'dart:math' hide log;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malaundry_kurir_flutter/data/local/app_config.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/app_config_model.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/account_repository/account_repo.dart';
import 'package:malaundry_kurir_flutter/data/notification_model/notification_model.dart';

import 'export_utils.dart';

class NotificationHandler extends ChangeNotifier {
  ///  ===== Constructor =====
  NotificationHandler(this.context) {
    this.init();
  }

  /// ===== Initial =====
  void init() async {
    initNotifLocal();
    await firebaseListen();
    await getNotif();
    await getAppConfig();
  }


  /// ===== Property =====
  BuildContext context;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  List<DataNotif> _listNotif = [];
  String jsonNotif;
  bool _isLoading = false;
  bool isChat = false;
  int _pageIndex = 0;
  int _detailJemputId;
  int _detailAntarId;

  int get detailJemputId => _detailJemputId;
  set detailJemputId(int val) {
    _detailJemputId = val;
    notifyListeners();
  }
  int get detailAntarId => _detailAntarId;
  set detailAntarId(int val) {
    _detailAntarId = val;
    notifyListeners();
  }


  int get pageIndex => _pageIndex;
  set pageIndex(int val) {
    _pageIndex = val;
    notifyListeners();
  }


  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<DataNotif> get listNotif => _listNotif;
  set listNotif(List<DataNotif> val) {
    _listNotif = val;
    notifyListeners();
  }
  /// ===== Method ======
  Future firebaseListen() async {
    firebaseMessaging.onTokenRefresh.listen((event) async {
      /// Set Token To Server SQL
      log("Is Not Chat");
      User user = User();
      user.firebaseToken = event.toString();
      await accountRepo.setFirebaseToken(user);
    });
    firebaseMessaging.configure(
      onMessage: (message) async {
        debugPrint("onMessage $message");
        // await getNotif();
        // showLocalNotif(message);
        // pageIndex = listNotif[0].body.contains("Pick up") == true ? 0 : 1;
        // pageIndex = listNotif[0].body.contains("Pick up") == true ? 0 : 1;
        pageIndex = message["notification"]["title"].contains("Pick up") == true ? 0 : 1;
        Fluttertoast.showToast(
          msg:
          // "onMessage order type : ${pageIndex == 0 ? "jemput" : "antar" }",
              // "${listNotif[0].datas.idJemput ?? listNotif[0].datas.idAntar}"
              "\nNotif Content : ${listNotif[0].body}",
              // "\norderType : ${ listNotif[0].body.contains("Pick up") ? "Jemput" : "Antar"}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,);
        // pageIndex = listNotif[0].body.contains("Pick up") == true ? 0 : 1;
        // navigateTo(
        // navigateRemoveUntil(
        //     context, listNotif[0].body.contains("Pick up") == true ? HomePage(pageIndex: 0) : HomePage(pageIndex: 1,));
      },
      onResume: (message) async {
        debugPrint("onResume $message");
        await getNotif();
        Fluttertoast.showToast(
          msg: "onResume order id : ${listNotif[0].id}"
                // "\nNotif Content : ${listNotif[0].body}",
              "\norderType : ${ listNotif[0].body.contains("Pick up") ? "Jemput" : "Antar"}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,);
        pageIndex = listNotif[0].body.contains("Pick up") == true ? 0 : 1;
        // navigateRemoveUntil(
        //     context, listNotif[0].body.contains("Pick up") == true ? HomePage(pageIndex: 0) : HomePage(pageIndex: 1,));
      },
      onLaunch: (message) async {
        debugPrint("onResume $message");
        await getNotif();
        // Fluttertoast.showToast(
        //   msg: "onLaunch order id : ${listNotif[0].id}"
        //       "\norderType : ${ listNotif[0].body.contains("Pick Up") ? "Jemput" : "Antar"}",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   backgroundColor: Colors.black,
        //   textColor: Colors.white,);
        pageIndex = listNotif[0].body.contains("Pick up") == true ? 0 : 1;
        // navigateRemoveUntil(
        //     context, listNotif[0].body.contains("Pick up") == true ? HomePage(pageIndex: 0) : HomePage(pageIndex: 1,));

      },
    );
    firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      debugPrint('Settings registered: $settings');
    });
  }

  /// Init local notif
  void initNotifLocal() {
    var android = new AndroidInitializationSettings('icon');
    var ios = new IOSInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      defaultPresentSound: true,
    );
    var platform = new InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(
      platform,
      onSelectNotification: onSelectNotification,
    );
  }

  /// onSelect Notif
  Future<void> onSelectNotification(String json) async {
    log("res $json");
    jsonNotif = json;
    Fluttertoast.showToast(
      msg: "json from notif : ${jsonNotif}",
      // "\nNotif Content : ${listNotif[0].body}",
      //     "\norderType : ${ listNotif[0].body.contains("Pick up") ? "Jemput" : "Antar"}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      textColor: Colors.white,);
    // if(json.contains("Pick up")){
    //   navigateTo(context, HomePage(pageSelectedParameter: 1));
    // } else {
    //   navigateTo(context, HomePage(pageSelectedParameter: 1));
    // }
    // final obj = jsonDecode(json);
  }

  /// Showlocal notif
  Future showLocalNotif(Map<String, dynamic> message) async {
    final android = AndroidNotificationDetails(
        'channel_id', 'channel_name', 'channel_description',
        icon: 'icon',
        largeIcon: const DrawableResourceAndroidBitmap('icon'),
        priority: Priority.high,
        importance: Importance.max,
        channelShowBadge: true);
    final iOS = IOSNotificationDetails(
        presentBadge: true, presentSound: true, presentAlert: true);
    final platform1 = NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPluginStatic.show(new Random().nextInt(100),
        message['data']['title'], message['data']['body'], platform1,
        payload: "hALOO");
  }

  // App Config
  Future getAppConfig() async {
    try {
      Response res = await dio.get(
        APP_CONFIG_URL,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        var result = AppConfigModel.fromJson(res.data);
        appConfigData.appConfig = result;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }
  // Get Notif
  Future getNotif() async {
    isLoading = true;
    try {
      Response res = await dio.get(
        NOTIFICATION_URL,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        log("data notif : ${res.data.toString()}");
        listNotif = NotificationModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception Notif $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception Notif $e");
      return e;
    } finally {
      isLoading = false;
    }
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginStatic =
    new FlutterLocalNotificationsPlugin();
