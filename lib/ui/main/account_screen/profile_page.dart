import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/profile_bloc/profile_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/colors.dart';
import 'package:malaundry_kurir_flutter/ui/config/spacing.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
// import 'package:malaundry_kurir_flutter/ui/icons/logo_malaundry_icons.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldkeyProfile = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProfileBloc(context,scaffoldKey: _scaffoldkeyProfile))
        ],
        child: Consumer<ProfileBloc>(
            builder: (context, profileBloc, _) => Container(
          child: Scaffold(
            key: _scaffoldkeyProfile,
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: medium,),
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      '$libImage/logo_malaundry.png',
                      width: 100,
                    ),
                    // child: Image.asset('assets/images/logo_malaundry.png'),
                    // child: Icon(LogoMalaundry.group),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: primaryColor,
                      //
                      // image: Icon(LogoMalaundry.group),
                      // image: DecorationImage(
                      //     image: NetworkImage(
                      //         'https://googleflutter.com/sample_image.jpg'),
                      //     fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(medium),
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          leading: Text("Title"),
                          trailing: Text("Kurir"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text("First Name"),
                          trailing: Text("${profileBloc.userProfile.namaDepan ?? "-"}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text("Last Name"),
                          trailing: Text("${profileBloc.userProfile.namaBelakang ?? "-"}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text("Phone"),
                          trailing: Text("+${profileBloc.userProfile.telp ?? "-"}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text("Username"),
                          trailing: Text("${profileBloc.userProfile.username ?? "-"}"),
                        ),
                        Divider(),
                        ListTile(
                          leading: Text("Address"),
                          trailing: Text("${profileBloc.userProfile.alamat ?? "-"}"),
                        ),
                        Divider(),
                        SizedBox(height: medium,),
                        Center(
                          child:Container(
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
                            color: primaryColor,
                            child:
                              // children: [
                                Text(
                                    "Log Out"
                                  // "${data?.status}"
                                ),
                                // Icon(
                                //     Icons
                                //         .keyboard_arrow_down,
                                //     size: 15)
                              // ],

                            onPressed: () {
                              // requestJemputBloc
                              //         ?.listShowAction[
                              //     index] = true;
                              // requestAntarBloc
                              //     ?.getDetailRequestAntar(
                              //     data);
                              profileBloc.logOut();
                              // setState(() {});
                            },
                          ),
                        ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
