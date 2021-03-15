import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_jemput_bloc/data_request_jemput_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:provider/provider.dart';

class RequestJemputPage extends StatefulWidget {
  @override
  _RequestJemputPageState createState() => _RequestJemputPageState();
}

class _RequestJemputPageState extends State<RequestJemputPage> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataRequestJemputBloc(context))
        // ChangeNotifierProvider(create: (context) => ,)
      ],
      child: Consumer<DataRequestJemputBloc>(
        builder: (context, requestJemputBloc, _) => RefreshIndicator(
          onRefresh: () async {
            requestJemputBloc.init();
          },
          child:
          // Scaffold(
          //   body:
          //   var data = requestJemputBloc.listDataRequestJemput.firstWhere((element) => element.idJemput == notifBloc?.detailJemputId);
      SafeArea(
              child: Container(
                child: Column(
                  children: [
                    HeaderSearch(
                      showAddButton: false,
                      onResetFilter: () => requestJemputBloc.init(),
                      onCancelSearch: () => requestJemputBloc.init(),
                      onSearch: (query) => requestJemputBloc.search(query),
                      onSubmitFilter:
                          (dateFrom, dateTo, filterBy, statusBy) async {
                        await requestJemputBloc?.getDataFilterBy(
                            dateFrom, dateTo, statusBy, filterBy);
                      },
                    ),
                    Expanded(
                      child: requestJemputBloc.isLoading
                          ? circularProgressIndicator()
                          : requestJemputBloc?.listDataRequestJemput?.length == 0
                              ? notFoundDataStatus()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: normal, vertical: normal),
                                  child:
                                  // Center(child: Text("Ini Request Jemput Page"),)
                                  ListView.builder(
                                    itemCount:
                                        requestJemputBloc?.listDataRequestJemput?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // log("isloaing ${requestJemputBloc.isLoading}");
                                      DataRequestJemput data =
                                          requestJemputBloc?.listDataRequestJemput[index];
                                      // bool showAction =
                                      //     requestJemputBloc?.listShowAction[index];
                                      var warna = primaryColor;
                                      var textButton = "Done";

                                      _setTextdanWarna(String status, String statusPersetujuanKurir) {
                                        if(status == "PROGRESS"){
                                          if(statusPersetujuanKurir == "MENUNGGU"){
                                            warna = labelColor;
                                            textButton = "Jemput";
                                          } else if(statusPersetujuanKurir == "DISETUJUI"){
                                            warna = onProgressButtonColor;
                                            textButton = "On Progress";
                                          }
                                        } else if(status == "CANCELED") {
                                          warna = canceledButtonColor;
                                          textButton = "Ditolak";
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
                                                      data?.namaKonsumen ??
                                                          "n/a",
                                                      style: sansPro(
                                                          // fontWeight:
                                                          //     FontWeight.w600,
                                                          // color: greyColor,
                                                          fontSize: medium),
                                                    ),
                                                    Text(
                                                      "${data?.createdDate}",
                                                        // "${formatDate(data?.createdAt, withTimes: true)}",
                                                        style: sansPro(
                                                            fontSize: medium,
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
                                                            requestJemputBloc
                                                                ?.getDetailRequestJemput(
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


