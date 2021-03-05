import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/model/data_order_model/data_order_model.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_antar/data_request_antar.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
// import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
// import 'package:ma_laundry/ui/bloc/order_bloc/data_request_antar_bloc.dart';
// import 'package:ma_laundry/ui/config/export_config.dart';
// import 'package:ma_laundry/utils/export_utils.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/order_bloc/data_order_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_antar_bloc/data_request_antar_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_jemput_bloc/data_request_jemput_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:provider/provider.dart';

import 'detail_request_antar_page.dart';

class RequestAntarPage extends StatefulWidget {
  @override
  _RequestAntarPageState createState() => _RequestAntarPageState();
}

class _RequestAntarPageState extends State<RequestAntarPage> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataRequestAntarBloc(context))
      ],
      child: Consumer<DataRequestAntarBloc>(
        builder: (context, requestAntarBloc, _) => RefreshIndicator(
          onRefresh: () async {
            requestAntarBloc.init();
          },
          child:
          // Scaffold(
          //   body:
            SafeArea(
              child: Container(
                child: Column(
                  children: [
                    HeaderSearch(
                      showAddButton: false,
                      onCancelSearch: () => requestAntarBloc.init(),
                      onSearch: (query) => requestAntarBloc.search(query),
                      onSubmitFilter:
                          (dateFrom, dateTo, filterBy, statusBy) async {
                        await requestAntarBloc?.getDataFilterBy(
                            dateFrom, dateTo, statusBy, filterBy);
                      },
                    ),
                    Expanded(
                      child: requestAntarBloc.isLoading
                          ? circularProgressIndicator()
                          : requestAntarBloc?.listDataRequestAntar?.length == 0
                              ? notFoundDataStatus()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: normal, vertical: normal),
                                  child:
                                  // Center(child: Text("Ini Request Jemput Page"),)
                                  ListView.builder(
                                    itemCount:
                                        requestAntarBloc?.listDataRequestAntar?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // log("isloaing ${requestAntarBloc.isLoading}");
                                      DataRequestAntar data =
                                          requestAntarBloc?.listDataRequestAntar[index];
                                      // bool showAction =
                                      //     requestJemputBloc?.listShowAction[index];
                                      var warna = primaryColor;
                                      var textButton = "Done";

                                      _setTextdanWarna(String status, String statusPersetujuanKurir) {
                                        if(status == "PROGRESS"){
                                          if(statusPersetujuanKurir == "MENUNGGU"){
                                            warna = labelColor;
                                            textButton = "Antar";
                                          } else if(statusPersetujuanKurir == "DISETUJUI"){
                                            warna = onProgressButtonColor;
                                            textButton = "On Progress";
                                          } else {
                                            warna = canceledButtonColor;
                                            textButton = "Ditolak";
                                          }
                                        }
                                      }

                                      _setTextdanWarna(data.status, data.statusPersetujuanKurir);

                                      return InkWell(
                                        onTap: () {
                                          // requestJemputBloc?.listShowAction[index] =
                                          //     false;
                                          // requestJemputBloc
                                          //     ?.getDetailRequestJemput(
                                          //     data);
                                          // setState(() {});
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            margin: EdgeInsets.all(medium),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data?.kode ??
                                                          "n/a",
                                                      style: sansPro(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      data?.namaKonsumen ??
                                                          "n/a",
                                                      style: sansPro(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16),
                                                    ),
                                                    // Text(
                                                    //     data?.konsumenFullName ??
                                                    //         "n/a",
                                                    //     style: sansPro(
                                                    //         color: greyColor)),
                                                    Text(
                                                      "${data?.createdDate}",
                                                        // "${formatDate(data?.createdAt, withTimes: true)}",
                                                        style: sansPro(
                                                            color: greyColor)),
                                                    // labelProgress(
                                                    //     data?.statusLaundry ??
                                                    //         "n/a")
                                                  ],
                                                ),
                                                    Container(
                                                      constraints: BoxConstraints(minWidth: 150),
                                                        height: 40,
                                                        child: RaisedButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          normal)),
                                                          textColor:
                                                              whiteNeutral,
                                                          color: warna,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  textButton
                                                                  // "${data?.status}"
                                                              ),
                                                              // Icon(
                                                              //     Icons
                                                              //         .keyboard_arrow_down,
                                                              //     size: 15)
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            // requestJemputBloc
                                                            //         ?.listShowAction[
                                                            //     index] = true;
                                                            requestAntarBloc
                                                                ?.getDetailRequestAntar(
                                                                data);
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          // ),
        ),
      ),
    );
  }


}


