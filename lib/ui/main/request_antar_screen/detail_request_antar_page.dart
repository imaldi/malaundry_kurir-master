import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_antar/data_request_antar.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/data/model/detail_order/detail_order.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_antar_bloc/data_request_antar_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_jemput_bloc/data_request_jemput_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/chat_screen/chat_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailRequestAntarPage extends StatefulWidget {
  final DataRequestAntar dataRequestAntar;
  final DataOrder dataOrder;

  const DetailRequestAntarPage({Key key, this.dataRequestAntar,this.dataOrder}) : super(key: key);
  @override
  _DetailRequestAntarPageState createState() => _DetailRequestAntarPageState();
}

class _DetailRequestAntarPageState extends State<DetailRequestAntarPage> {
  DataRequestAntar get dataRequestAntar => widget.dataRequestAntar;
  DataOrder get dataOrder => widget.dataOrder;
  FirebaseDatabase db = FirebaseDatabase.instance;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  DataRequestAntarBloc(context, dataDetailRequestAntar: dataRequestAntar))
        ],
        child: Consumer<DataRequestAntarBloc>(
            builder: (consumerContext, requestAntarBloc, _) {
              var serviceSatuan = dataOrder.satuan;
              var serviceKiloan = dataOrder.kiloan;
          return requestAntarBloc.isLoading
              ? circularProgressIndicator()
              : Scaffold(
                body: SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - 75,
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: normal, vertical: medium),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(normal)),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppBar(
                                      backgroundColor: whiteNeutral,
                                      centerTitle: true,
                                      leading: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: darkColor,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      title: Text(
                                        "Summary",
                                        style: sansPro(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: darkColor),
                                      ),
                                    ),
                                    SizedBox(height: medium),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: medium),
                                      width: widthScreen(context),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: normal),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: greyColor, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(medium),
                                              decoration: BoxDecoration(
                                                  color: greyNeutral,
                                                  border: Border.all(color: greyColor, width: 1),
                                                  borderRadius: BorderRadius.circular(normal)),
                                              child: InkWell(
                                                onTap: () {
                                                  requestAntarBloc.isVisibleKiloan = !requestAntarBloc.isVisibleKiloan;
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Service Kiloan",
                                                      style: sansPro(),
                                                    ),
                                                    requestAntarBloc.isVisibleKiloan ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Visibility(child: SizedBox(height: medium)),
                                            Visibility(
                                              visible: requestAntarBloc.isVisibleKiloan,
                                              child: Container(
                                                margin: EdgeInsets.all(medium),
                                                child: Column(
                                                  children: [
                                                    Table(
                                                      border: TableBorder.all(),
                                                      children: [
                                                        TableRow(children: [
                                                          TableCell(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Nama Paket',
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Kg',
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Harga',
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              )),
                                                          TableCell(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  'Subtotal',
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              )),
                                                        ]),
                                                      ],
                                                    ),
                                                    Table(
                                                        border: TableBorder.all(),
                                                        children:
                                                        // (serviceSatuan.isEmpty ?
                                                        //   [["-", "-", "-", "-"],["-", "-", "-", "-"]] :
                                                        returnListService(serviceKiloan)
                                                        // )
                                                            .map((e) => TableRow(
                                                            children: e
                                                                .map(
                                                                  (b) => TableCell(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(
                                                                        8.0),
                                                                    child: Text(
                                                                      '$b',
                                                                      textAlign:
                                                                      TextAlign.center,
                                                                    ),
                                                                  )),
                                                            )
                                                                .toList()))
                                                            .toList()),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: serviceSatuan.isNotEmpty,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: medium),
                                        width: widthScreen(context),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: normal),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: greyColor, width: 1),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(medium),
                                                decoration: BoxDecoration(
                                                    color: greyNeutral,
                                                    border:
                                                    Border.all(color: greyColor, width: 1),
                                                    borderRadius: BorderRadius.circular(normal)),
                                                child: InkWell(
                                                  onTap: () {
                                                    requestAntarBloc.isVisibleSatuan = !requestAntarBloc.isVisibleSatuan;
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Service Satuan",
                                                        style: sansPro(),
                                                      ),
                                                      requestAntarBloc.isVisibleSatuan ? Icon(Icons.keyboard_arrow_up) : Icon(Icons.keyboard_arrow_down)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Visibility(child: SizedBox(height: medium)),
                                              Visibility(
                                                visible: requestAntarBloc.isVisibleSatuan,
                                                child: Container(
                                                  margin: EdgeInsets.all(medium),
                                                  child: Column(
                                                    children: [
                                                      Table(
                                                        border: TableBorder.all(),
                                                        children: [
                                                          TableRow(children: [
                                                            TableCell(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'Nama Paket',
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                )),
                                                            TableCell(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'Pcs',
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                )),
                                                            TableCell(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'Harga',
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                )),
                                                            TableCell(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                    'Subtotal',
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                )),
                                                          ]),
                                                        ],
                                                      ),
                                                      Table(
                                                          border: TableBorder.all(),
                                                          children:
                                                          // (
                                                          // serviceKiloan.isEmpty ?
                                                          // [["-", "-", "-", "-"]] :
                                                          returnListService(serviceKiloan)
                                                          // )
                                                              .map((e) => TableRow(
                                                              children: e
                                                                  .map(
                                                                    (b) => TableCell(
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .all(8.0),
                                                                      child: Text(
                                                                        '$b',
                                                                        textAlign:
                                                                        TextAlign.center,
                                                                      ),
                                                                    )),
                                                              )
                                                                  .toList()))
                                                              .toList()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: medium),
                                      width: widthScreen(context),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: normal),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: greyColor, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(medium),
                                              decoration: BoxDecoration(
                                                  color: greyNeutral,
                                                  border: Border.all(color: greyColor, width: 1),
                                                  borderRadius: BorderRadius.circular(normal)),
                                              child: InkWell(
                                                onTap: (){requestAntarBloc.isVisibleDetail = !requestAntarBloc.isVisibleDetail;},
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Detail Order",
                                                      style: sansPro(),
                                                    ),
                                                    requestAntarBloc.isVisibleDetail ? Icon(Icons.keyboard_arrow_up): Icon(Icons.keyboard_arrow_down)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: requestAntarBloc.isVisibleDetail,
                                              child: Container(
                                                padding: EdgeInsets.all(medium),
                                                child: Column(
                                                  children: [
                                                    detailItem2(
                                                      context,
                                                      title: "Nomer Order",
                                                      content: dataOrder?.kodeTransaksi,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Tanggal Masuk",
                                                      content: dataOrder?.tanggalJam,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Nama Customer",
                                                      content: dataOrder?.konsumenFullName,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Kuota Cuci Terpakai",
                                                      content: dataOrder.kuotaCuciUsed + " Kg",
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Kuota Setrika Terpakai",
                                                      content: dataOrder.kuotaSetrikaUsed + " Pcs",
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Parfum",
                                                      content: dataOrder?.parfum,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Catatan",
                                                      content: dataOrder?.catatan,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Status Pembayaran",
                                                      content: dataOrder?.statusTagihan,
                                                      styleContent:
                                                      sansPro(fontWeight: FontWeight.bold),
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Metode Pembayaran",
                                                      content: dataOrder?.metodePembayaran,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Sisa Tagihan",
                                                      content:
                                                      "${formatMoney(dataOrder?.totalTagihan ?? "0")}",
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Jumlah Bayar",
                                                      content:
                                                      "${formatMoney(dataOrder?.jumlahBayar ?? "0")}",
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Diskon",
                                                      content:
                                                      "${formatMoney(dataOrder?.diskon ?? "0")}",
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Kembalian",
                                                      content:
                                                      "${formatMoney(dataOrder?.kembalian ?? "0")}",
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Status Laundry",
                                                      content: dataOrder?.statusLaundry,
                                                    ),
                                                    detailItem2(
                                                      context,
                                                      title: "Catatan Cancel",
                                                      content: dataOrder?.catatanCancel,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: medium),
                                  ],
                                ),

                                requestAntarBloc.dataDetailRequestAntar.status ==
                                        "PROGRESS"
                                    ? requestAntarBloc.dataDetailRequestAntar
                                                .statusPersetujuanKurir ==
                                            "MENUNGGU"
                                        ? Container(
                                  padding: EdgeInsets.fromLTRB(medium, 0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                          color: primaryColor,
                                                          width: 1,
                                                          // style: BorderStyle.solid
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            normal)),
                                                    child: Text('Terima',style: TextStyle(color:primaryColor),),
                                                    onPressed: () {
                                                      requestAntarBloc.updateRequestAntar(
                                                          dataRequestAntar.idAntar,
                                                          isTerima: true);
                                                      // Navigator.of(context).pop();
                                                      // requestAntarBloc
                                                      //     .getDetailRequestJemput(data);
                                                    },
                                                    // color: primaryColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            normal)),
                                                    child: Text('Tolak',style: TextStyle(color: Colors.white),),
                                                    onPressed: () {
                                                      requestAntarBloc.updateRequestAntar(
                                                          dataRequestAntar.idAntar,
                                                          isTerima: false);
                                                      // Navigator.of(context).pop();
                                                    },
                                                    color: canceledButtonColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : requestAntarBloc.dataDetailRequestAntar
                                                    .statusPersetujuanKurir ==
                                                "DISETUJUI"
                                            ? BottomAppBar(
                                              child: Container(
                                  padding: EdgeInsets.fromLTRB(medium, 0, high, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: MaterialButton(
                                                          shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                color: primaryColor,
                                                                width: 1,
                                                                // style: BorderStyle.solid
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  normal)),
                                                          child: Text('Diterima'),
                                                          onPressed: () {
                                                            requestAntarBloc
                                                                .updateRequestAntar(
                                                                dataRequestAntar.idAntar,
                                                                isReceived: true);
                                                            deleteWholeChatHistoryWithThisId(dataRequestAntar.idAntar);
                                                            Navigator.pop(context);
                                                            // requestAntarBloc
                                                            //     .getDetailRequestJemput(data);
                                                          },
                                                          // color: primaryColor,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          InkWell(
                                                              onTap: (){
                                                                navigateTo(context, ChatPage(dataRequestAntar: dataRequestAntar));
                                                                // navigateTo(context, ChatLoginPage());
                                                              },
                                                              child:
                                                          Icon(Icons.message,color: primaryColor,)),
                                                          SizedBox(width: medium),
                                                          InkWell(
                                                              onTap: (){
                                                                launch("tel://${dataRequestAntar.konsumen.user.telp}");
                                                              },
                                                              child: Icon(Icons.phone,color: primaryColor,)),
                                                          SizedBox(width: medium),
                                                          InkWell(
                                                              onTap: (){
                                                                MapUtils.openMap(dataRequestAntar.latitude, dataRequestAntar.longitude);
                                                              },
                                                              child: Icon(Icons.location_on, color: primaryColor,)),
                                                          SizedBox(width: medium),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            )
                                            : BottomAppBar(
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(medium, 0, 0, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: MaterialButton(
                                                          shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                color: primaryColor,
                                                                width: 1,
                                                                // style: BorderStyle.solid
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  normal)),
                                                          child: Text('Tutup'),
                                                          onPressed: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          // color: primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            )
                                    : Container(
                                  padding: EdgeInsets.fromLTRB(medium, 0, 0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: primaryColor,
                                                      width: 1,
                                                      // style: BorderStyle.solid
                                                    ),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        normal)),
                                                child: Text('Tutup'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                // color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                // SizedBox(height: medium)
                              ],
                            ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
              );
        }));
  }

  List<List<String>> returnListService(List<Transaksi> serviceSatuan) {
    var serviceList = serviceSatuan.map((elem) {
      // var satuan = isSatuan ? elem.jumlah : elem.satuanBerat;
      return [elem.namaService,elem.jumlah,elem.hargaService,
        // "nol"
        "${double.parse(elem.jumlah)*double.parse(elem.hargaService)}"
      ];
    }).toList();
    log(serviceList.toString());
    return serviceList;
  }

  Future<void> deleteWholeChatHistoryWithThisId(int idAntar) async {
    await db
        .reference()
        .child("message")
        .child("antar")
        .child(
        "$idAntar").remove();
  }
}
