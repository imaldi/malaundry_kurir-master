import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/login_page.dart';
import 'package:malaundry_kurir_flutter/ui/main/account_screen/reset_pin_page.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String idUser;
  OTPScreen(this.phone,{this.idUser});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String get idUser => widget.idUser;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    // color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border(
      bottom: BorderSide(color: Colors.black)
    )
    //     .all(
    //   // color: const Color.fromRGBO(126, 203, 224, 1),
    //   color: Colors.black,
    // ),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Verifikasi Kode OTP'),
      ),
      body: Center(
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
                  padding: EdgeInsets.symmetric(
                      horizontal: medium, vertical: high),
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            'Kode Verifikasi untuk \n+62 ${widget.phone.substring(2)}',
                            style: TextStyle(fontSize: medium),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: PinPut(
                          fieldsCount: 6,
                          textStyle: const TextStyle(fontSize: 25.0),
                          eachFieldWidth: 40.0,
                          eachFieldHeight: 55.0,
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          // inputDecoration: BoxDecoration(),
                          submittedFieldDecoration: pinPutDecoration,
                          selectedFieldDecoration: pinPutDecoration,
                          followingFieldDecoration: pinPutDecoration,
                          pinAnimationType: PinAnimationType.fade,
                          onSubmit: (pin) async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(PhoneAuthProvider.credential(
                                  verificationId: _verificationCode, smsCode: pin))
                                  .then((value) async {
                                if (value.user != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => ResetPINPage(idUser: idUser,)),
                                          (route) => false);
                                }
                              });
                            } catch (e) {
                              FocusScope.of(context).unfocus();
                              _scaffoldkey.currentState
                                  .showSnackBar(SnackBar(content: Text('invalid OTP')));
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Tidak menerima kode?"),
                        InkWell(child: Text("Kirim ulang",style: TextStyle(color: primaryColor),),onTap: (){_verifyPhone();},)
                      ],)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+62${widget.phone.substring(2)}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPINPage(idUser: idUser,)),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
    _pinPutController.text = "";
  }

  @override
  void initState() {
    super.initState();
    // progressDialog(context);
    // showLocalSnackbar("Mohon Tunggu, Redirect OTP", key)
    _verifyPhone();
    Fluttertoast.showToast(
        msg: "Mohon Tunggu, sedang redirect ke browser untuk mendapatkan kode OTP",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,);
  }
}