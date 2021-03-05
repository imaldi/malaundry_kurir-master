import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/data/network/dio_handler.dart';
import 'package:malaundry_kurir_flutter/data/network/network_export.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestJemputRepository {
  final Future<SharedPreferences> pref = SharedPreferences.getInstance();
  /// API GET Detail Order Laundry
  // Future getDetailRequestJemput(DataRequestJemput data) async {
  //   try {
  //     Response res = await dio.get(GET_DATA_REQUEST_JEMPUT_URL,
  //         queryParameters: {'id': "${data.idJemput}"},
  //         options: Options(headers: apiHeader.headers));
  //     // log(res.toString());
  //     if (res.statusCode == 200) {
  //       log(res.toString());
  //       return DataRequestJemput.fromJson(res.data);
  //     }
  //   } on DioError catch (e, st) {
  //     log("Exception $e");
  //     return DioHandler.parseDioErrorMessage(e, st);
  //   } catch (e) {
  //     log("Exception $e");
  //     return e;
  //   }
  // }

  /// API UPDATE REQUEST JEMPUT
  Future updateRequestJemput(int idTransaksi,{bool isTerima, isReceived}) async {
    Map<String, dynamic> query = {};
    var check = await pref;
    query['id_kurir'] =
    // 36;
    await check.get("id_kurir");
    if(isTerima != null){
      if(isTerima){
        query['status_persetujuan_kurir'] = "DISETUJUI";
      } else {
        query['status_persetujuan_kurir'] = "DITOLAK";
      }
    }
    else {
      if(isReceived == true){
        query['status'] = "COMPLETED";
      }
    }
    try {
      Response res = await dio.get(
          UPDATE_DATA_REQUEST_JEMPUT_URL + "${idTransaksi}",
          queryParameters: query,
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        // log(res.toString());
        return res.data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  // /// API SET Canceled LAUNDRY
  // Future setCanceledLaundry(DataOrder data, String note) async {
  //   try {
  //     Response res = await dio.post(
  //         SET_CANCEL_LAUNDRY_URL + "${data?.idTransaksi}",
  //         data: FormData.fromMap(
  //             {'catatan_cancel': note ?? "Cancel Order ya Pak/Bu"}),
  //         options: Options(headers: apiHeader.headers));
  //     if (res.statusCode == 200) {
  //       return res.data;
  //     }
  //   } on DioError catch (e, st) {
  //     log("Exception $e");
  //     return DioHandler.parseDioErrorMessage(e, st);
  //   } catch (e) {
  //     log("Exception $e");
  //     return e;
  //   }
  // }

  /// API GET Order Data
  Future getDataRequestJemput(
      {DateTime dateFrom,
        DateTime dateTo,
        String filterBy = "ALL",
        String statusBy}) async {
    Map<String, dynamic> query = {};
    // query['status_pengambilan'] = "BELUM";
    var check = await pref;
    query['id_kurir'] =
    // 36;
    await check.get("id_kurir");
    // query['id_kurir'] = 36;
    if (dateTo != null) {
      query['date_to'] = formatDate(dateTo);
    }
    if (dateFrom != null) {
      query['date_from'] = formatDate(dateFrom);
    }
    if (filterBy != null) {
      query['filter'] = filterBy;
    }
    if (statusBy != null) {
      query['status'] = statusBy;
    }

    try {
      Response res = await dio.post(GET_DATA_REQUEST_JEMPUT_URL,
          queryParameters: query, options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        // log(res.toString());
        return DataRequestJemputModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  Future getDetailRequestJemput(DataRequestJemput dataRequestJemput) async {
    try {
      Response res = await dio.get(GET_DATA_REQUEST_JEMPUT_URL,
          queryParameters: {'id': "${dataRequestJemput.idJemput}"},
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return DataRequestJemputModel.fromJson(res.data).data;
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


