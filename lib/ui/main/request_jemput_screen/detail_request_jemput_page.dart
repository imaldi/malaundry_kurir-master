import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_jemput_bloc/data_request_jemput_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/chat_screen/chat_page.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailRequestJemputPage extends StatefulWidget {
  final DataRequestJemput data;

  const DetailRequestJemputPage({Key key, this.data}) : super(key: key);
  @override
  _DetailRequestJemputPageState createState() =>
      _DetailRequestJemputPageState();
}

class _DetailRequestJemputPageState extends State<DetailRequestJemputPage> {
  DataRequestJemput get data => widget.data;
  FirebaseDatabase db = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) =>
                  DataRequestJemputBloc(context, dataDetailRequestJemput: data))
        ],
        child: Consumer<DataRequestJemputBloc>(
            builder: (consumerContext, requestJemputBloc, _) {
          return  requestJemputBloc.isLoading
              ? circularProgressIndicator()
              : Scaffold(
                body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                  child: Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //       // color: Colors.red[500],
                    //     ),
                    //     borderRadius: BorderRadius.all(Radius.circular(normal))),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 75,
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: normal, vertical: medium),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(normal)),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppBar(
                                shape: ContinuousRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(medium),
                                    topRight: Radius.circular(medium),
                                  ),),
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
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(medium),
                                        decoration: BoxDecoration(
                                            color: greyNeutral,
                                            border: Border.all(color: greyColor, width: 1),
                                            borderRadius: BorderRadius.circular(normal)),
                                        child: InkWell(
                                          onTap: (){requestJemputBloc.isVisibleDetail = !requestJemputBloc.isVisibleDetail;},
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Detail Order",
                                                style: sansPro(),
                                              ),
                                              requestJemputBloc.isVisibleDetail ? Icon(Icons.keyboard_arrow_up): Icon(Icons.keyboard_arrow_down)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: requestJemputBloc.isVisibleDetail,
                                        child: Container(
                                          padding: EdgeInsets.all(medium),
                                          child: Column(
                                            children: [
                                              detailItem2(
                                                context,
                                                title: "Total Berat",
                                                content: "${data.berat
                                                    .toString()} Kg",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Nama Cabang",
                                                content: data.namaCabang,
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Nama Konsumen",
                                                content: data.namaKonsumen,
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Nomor HP Konsumen",
                                                content: data.konsumen.user.telp,
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Alamat",
                                                content: data.konsumen.user.alamat,
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

                          if (requestJemputBloc.dataDetailRequestJemput
                                      .status ==
                                  "PROGRESS") requestJemputBloc.dataDetailRequestJemput.statusPersetujuanKurir == "MENUNGGU" ?

                                   BottomAppBar(
                                    shape: CircularNotchedRectangle(),
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(medium, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
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
                                              child: Text('Terima',style: TextStyle(color: primaryColor),),
                                              onPressed: () {
                                                requestJemputBloc.updateRequestJemput(
                                                    data.idJemput,
                                                    isTerima: true);
                                                // requestJemputBloc
                                                //     .getDetailRequestJemput(data);
                                              },
                                              // color: primaryColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      normal)),
                                              child: Text('Tolak',style: TextStyle(color: Colors.white),),
                                              onPressed: () {
                                                requestJemputBloc.updateRequestJemput(
                                                    data.idJemput,
                                                    isTerima: false);
                                                // Navigator.of(context).pop();
                                              },
                                              color: canceledButtonColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )

                              : requestJemputBloc.dataDetailRequestJemput.statusPersetujuanKurir == "DISETUJUI" ?
                          // (requestJemputBloc.dataDetailRequestJemput
                          //     .statusPersetujuanKurir ==
                          //     "DISETUJUI" && requestJemputBloc.dataDetailRequestJemput.status == "COMPLETED")
                          BottomAppBar(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(medium, 0, high, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(width: small,),
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
                                      child: Text('Diterima',style:TextStyle(color: primaryColor,)),
                                      onPressed: () {
                                        requestJemputBloc
                                            .updateRequestJemput(
                                            data.idJemput,
                                            isReceived: true);
                                        deleteWholeChatHistoryWithThisId(data.idJemput);
                                        // requestJemputBloc
                                        //     .getDetailRequestJemput(data);
                                      },
                                      // color: primaryColor,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            navigateTo(context, ChatPage(dataRequestJemput: data));
                                            // navigateTo(context, ChatLoginPage());
                                          },
                                          child:
                                      Icon(Icons.message,color: primaryColor,)),
                                      SizedBox(width: medium),
                                      InkWell(
                                          onTap: (){
                                            launch("tel://${data.konsumen.user.telp}");
                                          },
                                          child: Icon(Icons.phone,color: primaryColor,)),
                                      SizedBox(width: medium),
                                      InkWell(
                                          onTap: (){
                                            MapUtils.openMap(double.parse(data.latitude), double.parse(data.longitude));
                                          },
                                          child: Icon(Icons.location_on, color: primaryColor,)),
                                      SizedBox(width: medium),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )

                                  :
                          BottomAppBar(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(medium, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // SizedBox(width: small,),
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
                                      child: Text('Tutup',style: TextStyle(color: primaryColor,),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ) else BottomAppBar(

                            child: Container(
                              padding: EdgeInsets.fromLTRB(medium, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // SizedBox(width: medium,),
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
                                      child: Text('Tutup',style: TextStyle(color: primaryColor,),),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      // color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
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
                // bottomNavigationBar: ,
              );
        }));
  }

  Future<void> deleteWholeChatHistoryWithThisId(int idJemput) async {
    await db
        .reference()
        .child("message")
        .child("jemput")
        .child(
        "$idJemput").remove();
  }
}
