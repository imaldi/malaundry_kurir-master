import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malaundry_kurir_flutter/data/local/account_data.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/data/model/cek_user_response/cek_user_response.dart';
import 'package:malaundry_kurir_flutter/data/model/reset_pin_response/reset_pin_response.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/account_repository/account_repo.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/check_number_to_change_pin_repository/check_number_to_change_pin_repo.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/login_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/otp_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/reset_pin_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/home_screen/home_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';

class CheckNumberToChangePinBloc extends ChangeNotifier {
  CheckNumberToChangePinBloc(this.context, 
      {this.scaffoldKey}
      ) {
    // sessionManager.checkSession(context);
  }

  /// Property
  bool _isLoading = false;
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
  final _checkNumberToChangePinRepo = CekNumberRepository();

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// State
  Future cekNumber(String noHP) async {
    FocusScope.of(context).unfocus();
    isLoading = true;
    var res = await _checkNumberToChangePinRepo.cekNumber(noHP);
    if (res is CekNomorResponse) {
      if(res.data.isNotEmpty){
        log("Cek Nomor Response : ${res.data[0].toString()}");
        navigateTo(context, OTPScreen(res.data[0].telp, idUser: res.data[0].id.toString()));
      }
    } else {
      showLocalSnackbar(res, scaffoldKey);
    }

    isLoading = false;
  }

  Future setPinUser(String idUser, String pin_number)async{
    isLoading = true;
    var res = await _checkNumberToChangePinRepo.setPinUser(idUser, pin_number);
    if (res is UpdateUserResponse) {
      if(res.status){
        // log("Reset Pin : ${res.data.toString()}");
        Fluttertoast.showToast(
          msg: "Sukses Update PIN",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,);
        navigateTo(context, LoginPage());
      }
    } else {
      showLocalSnackbar(res, scaffoldKey);
    }

    isLoading = false;
  }

  // Future saveSession(AccountModel res) async {
  //   var save = await pref;
  //   await save.setString("user", jsonEncode(res?.user?.toJson()));
  //   await save.setString("accessToken", res.token);
  //   await save.setInt("id_kurir",res?.user?.id);
  //   apiHeader.token = res.token;
  //   accountData.account = res.user;
  //   await _checkNumberToChangePinRepo.setFirebaseToken(res.user);
  //   if (res?.user != null) {
  //     navigateRemoveUntil(context,
  //         HomePage()
  //       // OrderPage()
  //       //   RequestJemputPage()
  //     );
  //   }
  //   // log("User ${jsonEncode(res?.user?.toJson())}");
  // }
}
