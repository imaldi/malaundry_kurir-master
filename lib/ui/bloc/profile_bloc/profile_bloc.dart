import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malaundry_kurir_flutter/data/local/account_data.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/account_repository/account_repo.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/login_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/home_screen/home_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';

class ProfileBloc extends ChangeNotifier {
  ProfileBloc(this.context,
      {this.scaffoldKey}
      ) {
    init();
    // sessionManager.checkSession(context);
  }

  init() async {
    isLoading = true;
    await fetchProfile();
    isLoading = false;
  }

  /// Property
  bool _isLoading = false;
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
  // final _accountRepo = AccountRepository();
  User _userProfile = User();
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  User get userProfile => _userProfile;
  set userProfile(User val){
    _userProfile = val;
    notifyListeners();
  }

  /// State
  // Future loginUser(User user) async {
  //   FocusScope.of(context).unfocus();
  //   isLoading = true;
  //   var res = await _accountRepo.loginUser(user);
  //   if (res is AccountModel) {
  //     if (res.status == true && res.user.level == "KURIR") {
  //       await saveSession(res);
  //       // debugPrint(res.toString());
  //     } else {
  //       showLocalSnackbar(res.message, scaffoldKey);
  //     }
  //   } else {
  //     showLocalSnackbar(res, scaffoldKey);
  //   }
  //
  //   isLoading = false;
  // }

  // Future saveSession(AccountModel res) async {
  //   var save = await pref;
  //   await save.setString("user", jsonEncode(res?.user?.toJson()));
  //   await save.setString("accessToken", res.token);
  //   await save.setInt("id_kurir",res?.user?.id);
  //   apiHeader.token = res.token;
  //   accountData.account = res.user;
  //   await _accountRepo.setFirebaseToken(res.user);
  //   if (res?.user != null) {
  //     navigateRemoveUntil(context,
  //         HomePage()
  //       // OrderPage()
  //       //   RequestJemputPage()
  //     );
  //   }
  //   log("User ${jsonEncode(res?.user?.toJson())}");
  // }
  
  Future fetchProfile() async {
    isLoading = true;
    var fetchProfile = await pref;
    var user = jsonDecode(fetchProfile.getString("user"));
    log(user.toString());
    isLoading = false;
    userProfile.level = user['level'];
    userProfile.namaDepan = user['nama_depan'];
    userProfile.namaBelakang = user['nama_belakang'];
    userProfile.telp = user['telp'];
    userProfile.username = user['username'];
    userProfile.alamat = user['alamat'];
  }

  Future logOut() async {
    var getPref = await pref;
    getPref.clear();
    // showLocalSnackbar("Logout Berhasil", scaffoldKey);
    Fluttertoast.showToast(
      msg: "Logout Berhasil",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,);
    navigateRemoveUntil(context,LoginPage());

  }
}
