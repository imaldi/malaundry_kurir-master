import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/splash_screen/splash_screen.dart';

import 'ui/main/account_screen/login_page.dart';

void main({String env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  env = env ?? "dev";
  await GlobalConfiguration().loadFromPath("assets/config/$env.json");
  print("Base Url : ${GlobalConfiguration().get("rootUrl")}");
  Firebase.initializeApp();
  runApp(Routes());
}

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Color(0xFFECF0F5),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: whiteNeutral),
            centerTitle: true,
            textTheme: TextTheme(
                title: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: whiteNeutral)),
            actionsIconTheme: IconThemeData(color: whiteNeutral)),
      ),
      debugShowCheckedModeBanner: false,
      home:
        // OrderPage(),
      // DetailOrderPage(),
      // LoginPage(),
      SplashScreen(),
      // HomePage(),
    );
  }
}
