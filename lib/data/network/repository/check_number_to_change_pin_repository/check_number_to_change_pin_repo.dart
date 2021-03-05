import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:malaundry_kurir_flutter/data/model/account_model/account_model.dart';
import 'package:malaundry_kurir_flutter/data/model/cek_user_response/cek_user_response.dart';
import 'package:malaundry_kurir_flutter/data/model/reset_pin_response/reset_pin_response.dart';
// import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
import '../../network_export.dart';

class CekNumberRepository {
  ///
  Future cekNumber(String noHP) async {
    try {
      Response res = await dio.get(
        GET_CEK_NUMBER_URL,
        queryParameters: {"telp" : noHP},
        // data: FormData.fromMap(user.toJson()),
      );
      if (res.statusCode == 200) {
        return CekNomorResponse.fromJson(res?.data);
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API SET Firebase Token
  Future setPinUser(String idUser, String pin_number) async {
    // print("Token Firebase ${user.firebaseToken}");
    try {
      Response res = await dio.post(UPDATE_USER+"$idUser",
          data: FormData.fromMap({
            'pin': pin_number,
          }),)
          // options: Options(headers: apiHeader.headers))
      ;
      log("${res.data}");
      if (res.statusCode == 200) {
        return UpdateUserResponse.fromJson(res?.data);
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }
}
