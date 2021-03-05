import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/check_number_to_change_pin_bloc/check_number_to_change_pin_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/request_antar_bloc/data_request_antar_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/colors.dart';
import 'package:malaundry_kurir_flutter/ui/config/spacing.dart';
import 'package:provider/provider.dart';

import 'otp_page.dart';

class CheckPhoneNumberPage extends StatefulWidget {
  @override
  _CheckPhoneNumberPageState createState() => _CheckPhoneNumberPageState();
}

class _CheckPhoneNumberPageState extends State<CheckPhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: "82235539449");
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context) => CheckNumberToChangePinBloc(context))
    ],
    child: Consumer<CheckNumberToChangePinBloc>(
    builder: (context, checkNumberToChangePinBloc, _) =>  Scaffold(
        body:Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: medium, vertical: medium),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(normal)),
                  child: Container(
                    width: widthScreen(context),
                    height: heightScreen(context)/3,
                    padding: EdgeInsets.symmetric(
                        horizontal: medium, vertical: high),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Container(
                            // margin: EdgeInsets.only(top: 60),
                            child: Center(
                              child: Text(
                                'Reset PIN',
                                style: TextStyle( fontSize: medium),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                prefix: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('+62'),
                                ),
                              ),
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              controller: _controller,
                            ),
                          )
                        ]),
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
                            color: primaryColor,
                            onPressed: () {
                              checkNumberToChangePinBloc.cekNumber("62${_controller.text}");
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => OTPScreen(_controller.text)));
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
