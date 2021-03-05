import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/local/account_data.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/account_repository/account_repo.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/home_screen/home_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/order_screen/order_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/request_jemput_screen/request_jemput_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
// import 'package:ma_laundry/data/local/account_data.dart';
// import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
// import 'package:ma_laundry/data/network/network_export.dart';
// import 'package:ma_laundry/data/network/repository/account_repository/account_repo.dart';
// import 'package:ma_laundry/ui/config/export_config.dart';
// import 'package:ma_laundry/ui/main/home_screen/home_page.dart';
// import 'package:ma_laundry/utils/navigator_helper.dart';
// import 'package:ma_laundry/utils/session_manager.dart';

class LoginBloc extends ChangeNotifier {
  LoginBloc(this.context, {this.scaffoldKey}) {
    // sessionManager.checkSession(context);
  }

  /// Property
  bool _isLoading = false;
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
  final _accountRepo = AccountRepository();
  FirebaseMessaging firebaseMessaging  = FirebaseMessaging();

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// State
  Future loginUser(User user) async {
    FocusScope.of(context).unfocus();
    isLoading = true;
    var res = await _accountRepo.loginUser(user);
    if (res is AccountModel) {
      if (res.status == true && res.user.level == "KURIR") {
        await saveSession(res);
        // debugPrint(res.toString());
      } else {
        showLocalSnackbar(res.message, scaffoldKey);
      }
    } else {
      showLocalSnackbar(res, scaffoldKey);
    }

    isLoading = false;
  }

  Future saveSession(AccountModel res) async {
    var save = await pref;
    await save.setString("user", jsonEncode(res?.user?.toJson()));
    await save.setString("accessToken", res.token);
    await save.setInt("id_kurir", res?.user?.id);
    var _token = await firebaseMessaging.getToken();
    apiHeader.token = res.token;
    accountData.account = res.user;
    accountData.account.firebaseToken = _token;
    log("Account Data ${accountData.account.toJson()}");
    await _accountRepo.setFirebaseToken(res.user);
    if (res?.user != null) {
      navigateRemoveUntil(context, HomePage()
          // OrderPage()
          //   RequestJemputPage()
          );
    }
    // log("User ${jsonEncode(res?.user?.toJson())}");
  }
}
