import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_antar/data_request_antar.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/data/model/detail_order/detail_order.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/data_request_antar_repository/request_antar_repo.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/data_request_jemput_repository/request_jemput_repo.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/request_antar_screen/detail_request_antar_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/request_jemput_screen/detail_request_jemput_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';

class DataRequestAntarBloc extends ChangeNotifier {
  /// === Constructor ===
  DataRequestAntarBloc(this.context,{this.dataDetailRequestAntar,this.dataOrder}) {
    if(this.dataDetailRequestAntar == null){
      this.init();
    }
  }

  /// ==== Initial ===
  init() async {
    isLoading = true;
    await getDataRequestAntar();
    isLoading = false;
  }

  /// ==== Property ===
  List<DataRequestAntar> listDataRequestAntar = [];
  List<bool> listShowAction = [];
  List<DataRequestAntar> backupListDataAntar = [];
  DataRequestAntar dataDetailRequestAntar;
  DataOrder dataOrder;
  BuildContext context;
  bool _isLoading = false;
  bool _isVisibleSatuan = true;
  bool _isVisibleKiloan = true;
  bool _isVisibleDetail = true;
  final requestAntarRepo = RequestAntarRepository();

  bool get isVisibleSatuan => _isVisibleSatuan;
  set isVisibleSatuan(bool val) {
    try {
      _isVisibleSatuan = val;
      notifyListeners();
    } catch (e) {}
  }
  bool get isVisibleKiloan => _isVisibleKiloan;
  set isVisibleKiloan(bool val) {
    try {
      _isVisibleKiloan = val;
      notifyListeners();
    } catch (e) {}
  }
  bool get isVisibleDetail => _isVisibleDetail;
  set isVisibleDetail(bool val) {
    try {
      _isVisibleDetail = val;
      notifyListeners();
    } catch (e) {}
  }
  
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      _isLoading = val;
      notifyListeners();
    } catch (e) {}
  }

  /// ==== Method ====
  Future getDetailRequestAntar(DataRequestAntar dataRequestAntar) async {
    // DataRequestJemput data;
    progressDialog(context);

    var resRequestAntar = await requestAntarRepo.getDetailRequestAntar(dataRequestAntar);
    var resDetailOrder = await requestAntarRepo.getDetailOrder(dataRequestAntar);

    // log(dataRequestJemput.toString());
    Navigator.pop(context);
    if (
    // dataRequestJemput != null
    resRequestAntar != null &&
    resDetailOrder != null
    ) {
      // dataDetailRequestAntar = res[0];
      dataOrder = resDetailOrder[0];
      dataDetailRequestAntar = resRequestAntar[0];
      navigateTo(context, DetailRequestAntarPage(dataRequestAntar: dataDetailRequestAntar,dataOrder: dataOrder,)).then((value) {
        init();
      });
    }
  }

  Future getDataRequestAntar() async {
    try {
      isLoading = true;
      var res = await requestAntarRepo.getDataRequestAntar();
      isLoading = false;
      if (res != null) {
        listShowAction.clear();
        backupListDataAntar.clear();
        listDataRequestAntar = res;
        backupListDataAntar.addAll(listDataRequestAntar);
        // listDataRequestAntar.forEach((element) {
        //   listShowAction.add(false);
        // });
      }
      notifyListeners();
    } catch (e) {}
  }

  // Update Data
  Future updateRequestAntar(int idData, {bool isTerima, isReceived}) async {
    // progressDialog(context);
    await requestAntarRepo.updateRequestAntar(idData,isTerima: isTerima, isReceived: isReceived).then((value) {
      // Navigator.pop(context);
      init();
    });
  }

  // Set Cancel Data
  // Future setCancel(DataOrder data) async {
  //   dialogNoteCancel(
  //     context,
  //     onSubmit: (note) async {
  //       progressDialog(context);
  //       await orderRepo.setCanceledLaundry(data, note).then((value) {
  //         Navigator.pop(context);
  //         Navigator.pop(context);
  //         init();
  //       });
  //     },
  //   );
  // }
  //
  // // Get Data Filter By
  Future getDataFilterBy(DateTime dateFrom, DateTime dateTo, String statusBy,
      String filterBy) async {
    isLoading = true;
    listDataRequestAntar.clear();
    backupListDataAntar.clear();
    notifyListeners();
    var res = await requestAntarRepo.getDataRequestAntar(
        dateTo: dateTo,
        dateFrom: dateFrom,
        statusBy: statusBy,
        filterBy: filterBy);
    isLoading = false;
    if (res != null) {
      listDataRequestAntar = res;
      backupListDataAntar.addAll(listDataRequestAntar);
      listShowAction.clear();
      listDataRequestAntar.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }
  //
  // Search Data
  void search(String query) {
    listDataRequestAntar = backupListDataAntar;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listDataRequestAntar = listDataRequestAntar
          .where((e) =>
            e.kode.toLowerCase().contains(query) ||
            e.namaKonsumen.toLowerCase().contains(query))
              // e.kodeTransaksi.toLowerCase().contains(query) ||
              // e.konsumenFullName.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listDataRequestAntar.forEach((element) {
        listShowAction.add(false);
      });
      notifyListeners();
    }
  }
}
