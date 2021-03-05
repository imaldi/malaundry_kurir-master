// import 'package:flutter/material.dart';
// import 'package:malaundry_kurir_flutter/data/model/data_order_model/data_order_model.dart';
// import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
// import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
// // import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
// // import 'package:ma_laundry/ui/config/export_config.dart';
// // import 'package:ma_laundry/utils/export_utils.dart';
//
// class DetailOrderPage extends StatefulWidget {
//   final DataOrder data;
//
//   const DetailOrderPage({Key key, this.data}) : super(key: key);
//   @override
//   _DetailOrderPageState createState() => _DetailOrderPageState();
// }
//
// class _DetailOrderPageState extends State<DetailOrderPage> {
//   DataOrder get data => widget.data;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: normal, vertical: medium),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadiusDirectional.circular(normal)),
//               elevation: 5,
//               child: Column(
//                 children: [
//                   AppBar(
//                     backgroundColor: whiteNeutral,
//                     centerTitle: true,
//                     leading: IconButton(
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         color: darkColor,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                     title: Text(
//                       "Summary",
//                       style: sansPro(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20,
//                           color: darkColor),
//                     ),
//                   ),
//                   SizedBox(height: medium),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: medium),
//                     width: widthScreen(context),
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: normal),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: greyColor, width: 1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(medium),
//                             decoration: BoxDecoration(
//                                 color: greyNeutral,
//                                 border: Border.all(color: greyColor, width: 1),
//                                 borderRadius: BorderRadius.circular(normal)),
//                             child: InkWell(
//                               onTap: () {},
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Service Kiloan",
//                                     style: sansPro(),
//                                   ),
//                                   Icon(Icons.keyboard_arrow_down)
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Visibility(child: SizedBox(height: medium)),
//                           Visibility(
//                             child: Container(
//                               margin: EdgeInsets.all(medium),
//                               child: Column(
//                                 children: [
//                                   Table(
//                                     border: TableBorder.all(),
//                                     children: [
//                                       TableRow(children: [
//                                         TableCell(
//                                             child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             'Nama Paket',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )),
//                                         TableCell(
//                                             child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             'Kg',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )),
//                                         TableCell(
//                                             child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             'Harga',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )),
//                                         TableCell(
//                                             child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             'Subtotal',
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )),
//                                       ]),
//                                     ],
//                                   ),
//                                   Table(
//                                       border: TableBorder.all(),
//                                       children: [
//                                         ["a", "b", "c", "d"]
//                                       ]
//                                           .map((e) => TableRow(
//                                               children: e
//                                                   .map(
//                                                     (b) => TableCell(
//                                                         child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Text(
//                                                         '$b',
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                       ),
//                                                     )),
//                                                   )
//                                                   .toList()))
//                                           .toList()),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: medium),
//                       width: widthScreen(context),
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: normal),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: greyColor, width: 1),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(medium),
//                               decoration: BoxDecoration(
//                                   color: greyNeutral,
//                                   border:
//                                       Border.all(color: greyColor, width: 1),
//                                   borderRadius: BorderRadius.circular(normal)),
//                               child: InkWell(
//                                 onTap: () {},
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Service Satuan",
//                                       style: sansPro(),
//                                     ),
//                                     Icon(Icons.keyboard_arrow_down)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Visibility(child: SizedBox(height: medium)),
//                             Visibility(
//                               child: Container(
//                                 margin: EdgeInsets.all(medium),
//                                 child: Column(
//                                   children: [
//                                     Table(
//                                       border: TableBorder.all(),
//                                       children: [
//                                         TableRow(children: [
//                                           TableCell(
//                                               child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'Nama Paket',
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           )),
//                                           TableCell(
//                                               child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'Pcs',
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           )),
//                                           TableCell(
//                                               child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'Harga',
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           )),
//                                           TableCell(
//                                               child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               'Subtotal',
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           )),
//                                         ]),
//                                       ],
//                                     ),
//                                     Table(
//                                         border: TableBorder.all(),
//                                         children: [
//                                           ["a", "b", "c", "d"]
//                                         ]
//                                             .map((e) => TableRow(
//                                                 children: e
//                                                     .map(
//                                                       (b) => TableCell(
//                                                           child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Text(
//                                                           '$b',
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                       )),
//                                                     )
//                                                     .toList()))
//                                             .toList()),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: medium),
//                     width: widthScreen(context),
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: normal),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: greyColor, width: 1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(medium),
//                             decoration: BoxDecoration(
//                                 color: greyNeutral,
//                                 border: Border.all(color: greyColor, width: 1),
//                                 borderRadius: BorderRadius.circular(normal)),
//                             child: InkWell(
//                               onTap: () {},
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Detail Order",
//                                     style: sansPro(),
//                                   ),
//                                   Icon(Icons.keyboard_arrow_down)
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Visibility(
//                             child: Container(
//                               padding: EdgeInsets.all(medium),
//                               child: Column(
//                                 children: [
//                                   detailItem2(
//                                     context,
//                                     title: "Nomer Order",
//                                     content: data?.kodeTransaksi,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Tanggal Masuk",
//                                     content: data?.tanggalJam,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Nama Customer",
//                                     content: data?.konsumenFullName,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Kuota Cuci Terpakai",
//                                     content: data.kuotaCuciUsed + " Kg",
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Kuota Setrika Terpakai",
//                                     content: data.kuotaSetrikaUsed + " Pcs",
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Parfum",
//                                     content: data?.parfum,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Catatan",
//                                     content: data?.catatan,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Status Pembayaran",
//                                     content: data?.statusTagihan,
//                                     styleContent:
//                                         sansPro(fontWeight: FontWeight.bold),
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Metode Pembayaran",
//                                     content: data?.metodePembayaran,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Sisa Tagihan",
//                                     content:
//                                         "${formatMoney(data?.totalTagihan ?? "0")}",
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Jumlah Bayar",
//                                     content:
//                                         "${formatMoney(data?.jumlahBayar ?? "0")}",
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Diskon",
//                                     content:
//                                         "${formatMoney(data?.diskon ?? "0")}",
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Kembalian",
//                                     content:
//                                         "${formatMoney(data?.kembalian ?? "0")}",
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Status Laundry",
//                                     content: data?.statusLaundry,
//                                   ),
//                                   detailItem2(
//                                     context,
//                                     title: "Catatan Cancel",
//                                     content: data?.catatanCancel,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: medium),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
