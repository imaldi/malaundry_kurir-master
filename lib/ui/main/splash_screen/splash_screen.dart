import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/login_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/home_screen/home_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    sessionManager.checkSession(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator(),),);
  }
}
