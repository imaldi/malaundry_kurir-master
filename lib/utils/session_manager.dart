import 'dart:convert';
import 'dart:developer';
import 'package:malaundry_kurir_flutter/data/local/account_data.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/login_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/home_screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigator_helper.dart';

final Future<SharedPreferences> pref = SharedPreferences.getInstance();

class SessionManager {
  Future checkSession(context) async {
    var check = await pref;
    var user = await check.get("user");
    var token = await check.get("accessToken");
    apiHeader.token = token;
    if (user != null && token != null) {
      accountData.account = User.fromJson(jsonDecode(user));
      log("Headers : ${apiHeader.headers}");
      if (user != null && token != null) {
        navigateRemoveUntil(context, HomePage()
            // OrderPage()
            // RequestJemputPage()
            );
      }

    }else {
      navigateRemoveUntil(context, LoginPage());
    }
  }

  Future clearSession(context) async {
    var session = await pref;
    session.clear();
    // session.commit();

    /// Navigate to Screen
  }
}

final sessionManager = SessionManager();
