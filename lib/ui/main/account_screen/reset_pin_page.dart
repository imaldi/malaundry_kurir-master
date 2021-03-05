import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malaundry_kurir_flutter/ui/bloc/check_number_to_change_pin_bloc/check_number_to_change_pin_bloc.dart';
import 'package:malaundry_kurir_flutter/ui/config/colors.dart';
import 'package:malaundry_kurir_flutter/ui/config/spacing.dart';
import 'package:malaundry_kurir_flutter/ui/config/widget.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import 'otp_page.dart';

class ResetPINPage extends StatefulWidget {
  final String idUser;
  ResetPINPage({this.idUser});
  @override
  _ResetPINPageState createState() => _ResetPINPageState();
}

class _ResetPINPageState extends State<ResetPINPage> {
  var obscurePin = true;
  var obscurePinKonfirmasi = true;

  String get idUser => widget.idUser;
  String newPin, newPinConfirm;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _pinPutController = TextEditingController();
    final TextEditingController _pinPutConfirmationController =
        TextEditingController();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    void validateForm(CheckNumberToChangePinBloc checkNumberToChangePinBloc) {
      final FormState form = _formKey.currentState;
      if (form.validate())
      // {
      // Fluttertoast.showToast(
      //   msg: "PIN tidak sama",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.black,
      //   textColor: Colors.white,);
      // } else
      {
        form.save();
        checkNumberToChangePinBloc.setPinUser(idUser, newPin);
      }
    }


    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => CheckNumberToChangePinBloc(context,
                  scaffoldKey: _scaffoldKey))
        ],
        child: Consumer<CheckNumberToChangePinBloc>(
            builder: (context, checkNumberToChangePinBloc, _) => Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: Text('Reset PIN Baru'),
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: medium, vertical: medium),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(normal)),
                            child: Form(
                              key: _formKey,
                              child: Container(
                                width: widthScreen(context),
                                padding: EdgeInsets.symmetric(
                                    horizontal: medium, vertical: high),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 40),
                                      child: Center(
                                        child: Text(
                                          // 'Verify +62-${widget.phone}',
                                          'Reset Pin',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(medium),
                                      // child: TextFormField(
                                      //   controller: _pinPutController,
                                      //   validator: (value){
                                      //     if(value.isEmpty){
                                      //       return "PIN harus diisi";
                                      //     } else if(value.length < 6){
                                      //       return "PIN tidak boleh kurang dari 6";
                                      //     }
                                      //     return null;
                                      //   },
                                      //   // onSaved:(value){ newPin = value;},
                                      //   onChanged:(value){ newPin = value;},
                                      //   maxLength: 6,
                                      //   keyboardType: TextInputType.number,
                                      //   obscureText: _obscurePin,
                                      //   decoration: InputDecoration(
                                      //     hintText: "Pin",
                                      //     suffixIcon: IconButton(
                                      //       icon: Icon(_obscurePin
                                      //           ? Icons.visibility
                                      //           : Icons.visibility_off),
                                      //       onPressed: () {
                                      //         setState(() {
                                      //           _pinPutController.text = newPin;
                                      //           return _obscurePin = !_obscurePin;
                                      //         });
                                      //       },
                                      //     ),
                                      //   ),
                                      //
                                      // ),
                                      child: CustomTextField(
                                        label: "NEW PIN",
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        obscureText: obscurePin,
                                        // suffixIcon: IconButton(
                                        //   icon: Icon(obscurePin
                                        //       ? Icons.visibility
                                        //       : Icons.visibility_off),
                                        //   onPressed: () {
                                        //     setState(() => obscurePin = !obscurePin);
                                        //   },
                                        // ),
                                        onChanged:(value){ newPin = value;},
                                        validator: (value){
                                          if(value.isEmpty){
                                            return "PIN harus diisi";
                                          } else if(value.length < 6){
                                            return "PIN tidak boleh kurang dari 6";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(medium),
                                      // child: TextFormField(
                                      //   validator: (value) {
                                      //     if (value.isEmpty) {
                                      //       return "PIN Konfirmasi harus diisi";
                                      //     } else if (value.length < 6) {
                                      //       return "PIN tidak boleh kurang dari 6";
                                      //     } else if (value !=
                                      //         _pinPutController.text) {
                                      //       return "PIN Konfirmasi tidak cocok";
                                      //     }
                                      //     return null;
                                      //   },
                                      //   onChanged: (value) {
                                      //     newPinConfirm = value;
                                      //   },
                                      //   controller:
                                      //       _pinPutConfirmationController,
                                      //   maxLength: 6,
                                      //   keyboardType: TextInputType.number,
                                      //   obscureText: _obscurePinKonfirmasi,
                                      //   decoration: InputDecoration(
                                      //     hintText: "Konfirmasi Pin",
                                      //     suffixIcon: IconButton(
                                      //       icon: Icon(_obscurePinKonfirmasi
                                      //           ? Icons.visibility
                                      //           : Icons.visibility_off),
                                      //       onPressed: () {
                                      //         setState(() {
                                      //           _pinPutConfirmationController.text = newPinConfirm;
                                      //           return _obscurePinKonfirmasi = !_obscurePinKonfirmasi;
                                      //         });
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                      child: CustomTextField(
                                        label: "PIN CONFIRM",
                                        maxLength: 6,
                                        keyboardType: TextInputType.number,
                                        obscureText: obscurePinKonfirmasi,
                                        // suffixIcon: IconButton(
                                        //   icon: Icon(obscurePinKonfirmasi
                                        //       ? Icons.visibility
                                        //       : Icons.visibility_off),
                                        //   onPressed: () {
                                        //     setState(() => obscurePinKonfirmasi = !obscurePinKonfirmasi);
                                        //   },
                                        // ),
                                        onChanged: (value) {
                                          newPinConfirm = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "PIN Konfirmasi harus diisi";
                                          } else if (value.length < 6) {
                                            return "PIN tidak boleh kurang dari 6";
                                          } else if (value !=
                                              newPin) {
                                            return "PIN Konfirmasi tidak cocok";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(top: medium),
                                      height: 45,
                                      width: widthScreen(context),
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      normal)),
                                          color: primaryColor,
                                          textColor: whiteNeutral,
                                          child: Text("Set New PIN"),
                                          onPressed:
                                              // (_pinPutController.text ==  _pinPutConfirmationController) ?
                                              () {
                                            // checkNumberToChangePinBloc.setPinUser(idUser, _pinPutController.text);
                                            validateForm(
                                                checkNumberToChangePinBloc);
                                          }
                                          // : null,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
