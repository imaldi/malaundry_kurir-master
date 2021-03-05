// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
// import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
//
// class DrawerHome extends StatelessWidget {
//   final List<String> listNameMenu;
//   final TabController controller;
//
//   const DrawerHome({Key key, this.listNameMenu, this.controller})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         width: widthScreen(context) * 0.75,
//         child: Drawer(
//           child: Container(
//             color: darkColor,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   /// Design Profile
//                   Container(
//                     padding: EdgeInsets.only(
//                         top: medium, right: medium, left: medium),
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(right: medium),
//                           width: 60,
//                           height: 60,
//                           child: ClipOval(
//                             child: Container(
//                               color: whiteNeutral,
//                               child: Image.network(samplePhoto),
//                             ),
//                           ),
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "ALexandre Pearcing",
//                               style: sansPro(
//                                   color: whiteNeutral, fontSize: medium),
//                             ),
//                             SizedBox(height: normal),
//                             Text(
//                               "Admin",
//                               style: sansPro(color: whiteNeutral, fontSize: 13),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(medium),
//                     color: darkNeutral,
//                     width: widthScreen(context),
//                     height: widthScreen(context) * 0.14,
//                   ),
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.symmetric(horizontal: medium),
//                     height: widthScreen(context) * 0.1,
//                     width: widthScreen(context),
//                     color: darkenColor,
//                     child: Text(
//                       "MAIN NAVIGATON",
//                       style: sansPro(color: whiteNeutral.withOpacity(0.25)),
//                     ),
//                   ),
//
//                   /// Design Menu
//                   menuDrawer()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget menuDrawer() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: listNameMenu?.length ?? 0,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text("${listNameMenu[index]}",
//               style: sansPro(color: whiteNeutral)),
//           onTap: () async {
//             if (index == (controller.length)) {
//               await sessionManager.clearSession(context);
//             } else {
//               Navigator.pop(context);
//               controller.animateTo(index,
//                   duration: Duration(milliseconds: 200),
//                   curve: Curves.bounceInOut);
//             }
//           },
//         );
//       },
//     );
//   }
// }
