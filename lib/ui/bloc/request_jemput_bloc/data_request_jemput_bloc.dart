import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/data/network/repository/data_request_jemput_repository/request_jemput_repo.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/request_jemput_screen/detail_request_jemput_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';

class DataRequestJemputBloc extends ChangeNotifier {
  /// === Constructor ===
  DataRequestJemputBloc(this.context,{this.dataDetailRequestJemput}) {
    if(this.dataDetailRequestJemput == null){
      this.init();
    }
  }

  /// ==== Initial ===
  init() async {
    isLoading = true;
    await getDataRequestJemput();
    isLoading = false;
  }

  /// ==== Property ===
  List<DataRequestJemput> listDataRequestJemput = [];
  List<bool> listShowAction = [];
  List<DataRequestJemput> backupListDataOrder = [];
  DataRequestJemput dataDetailRequestJemput;
  BuildContext context;
  bool _isLoading = false;
  bool _isVisibleDetail = true;
  final requestJemputRepo = RequestJemputRepository();

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      _isLoading = val;
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

  /// ==== Method ====
  Future getDetailRequestJemput(DataRequestJemput dataRequestJemput) async {
    // DataRequestJemput data;
    progressDialog(context);

    var res = await requestJemputRepo.getDetailRequestJemput(dataRequestJemput);

    // log(dataRequestJemput.toString());
    Navigator.pop(context);
    if (
    // dataRequestJemput != null
    res != null
    ) {
      dataDetailRequestJemput = res[0];
      // notifyListeners();
      navigateTo(context, DetailRequestJemputPage(data: dataDetailRequestJemput)).then((value) {
        init();
      });
    }
  }

  Future getDataRequestJemput() async {
    try {
      isLoading = true;
      var res = await requestJemputRepo.getDataRequestJemput();
      isLoading = false;
      if (res != null) {
        listShowAction.clear();
        backupListDataOrder.clear();
        listDataRequestJemput = res;
        backupListDataOrder.addAll(listDataRequestJemput);
        // listDataRequestJemput.forEach((element) {
        //   listShowAction.add(false);
        // });
      }
      notifyListeners();
    } catch (e) {}
  }

  // Update Data
  Future updateRequestJemput(int idData, {bool isTerima, isReceived}) async {

    await requestJemputRepo.updateRequestJemput(idData,isTerima: isTerima, isReceived: isReceived).then((value) {
      // Navigator.pop(context);
      // Navigator.pop(context);
      init();
    });
    // notifyListeners();
    // progressDialog(context);
  }

  // // Set Cancel Data
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
    listDataRequestJemput.clear();
    backupListDataOrder.clear();
    notifyListeners();
    var res = await requestJemputRepo.getDataRequestJemput(
        dateTo: dateTo,
        dateFrom: dateFrom,
        statusBy: statusBy,
        filterBy: filterBy);
    isLoading = false;
    if (res != null) {
      listDataRequestJemput = res;
      backupListDataOrder.addAll(listDataRequestJemput);
      listShowAction.clear();
      listDataRequestJemput.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }
  //
  // Search Data
  void search(String query) {
    listDataRequestJemput = backupListDataOrder;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listDataRequestJemput = listDataRequestJemput
          .where((e) =>
              // e.kodeTransaksi.toLowerCase().contains(query) ||
              e.namaKonsumen.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listDataRequestJemput.forEach((element) {
        listShowAction.add(false);
      });
      notifyListeners();
    }
  }
}
