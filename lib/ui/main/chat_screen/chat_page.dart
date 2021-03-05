import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:malaundry_kurir_flutter/data/model/chat_model/chat.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_antar/data_request_antar.dart';
import 'package:malaundry_kurir_flutter/data/model/data_request_jemput/data_request_jemput.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';

class ChatPage extends StatefulWidget {
  // final int idOrder;
  // final idUser;
  // final bool isJemputRequest;
  final DataRequestJemput dataRequestJemput;
  final DataRequestAntar dataRequestAntar;
  ChatPage(
      // this.isJemputRequest,
      {this.dataRequestJemput,
      this.dataRequestAntar});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  FirebaseMessaging fcm = FirebaseMessaging();
  FirebaseDatabase db = FirebaseDatabase.instance;
  List<Chat> chats = [];
  ScrollController _controller = ScrollController();
  String namaKonsumen ="";

  _scrollToBottom() {
    if (chats.length != 0) {
      setState(() {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

  StreamSubscription<Event> streamChatAdded;

  DataRequestJemput get dataRequestJemput => widget.dataRequestJemput;
  DataRequestAntar get dataRequestAntar => widget.dataRequestAntar;

  bool isJemputRequest = false;

  Future<void> sendMessage(String msg) async {
    /// INI BISA DIBUAT DISERVER UNTUK NAMBAHIN CHAT DAN KIRIM NOTIFIKASINYA
    isJemputRequest = (dataRequestJemput != null) ? true : false;
    // var data = dataRequestJemput ?? dataRequestAntar;
    /// Get Lawan Chat
    // Response res = await get(
    //   GET_DATA_REQUEST_JEMPUT_URL,
    //   // "http://172.16.0.14/chat_app/send_chat.php",
    //   params: {
    //     "id_kurir": widget.idUser.toString(),
    //     // "id_order": widget.idOrder.toString(),
    //     // "id_sender": widget.idUser.toString(),
    //   },
    // );
    // if (res.statusCode == 200) {
    //   ResGetOpponent opponent = resGetOpponentFromJson(res.body);

    /// Nambahin chat ke firebase
    await db
        .reference()
        .child("message")
        .child(isJemputRequest ? "jemput" : "antar")
        .child(
            "${isJemputRequest ? dataRequestJemput.idJemput : dataRequestAntar.idAntar}")
        .push()
        .set({
      "id_sender": dataRequestJemput?.idKurir ?? dataRequestAntar?.idKurir,
      "message": msg,
      "time": DateTime.now().millisecondsSinceEpoch,
    });

    /// Send Notifikasi
    Response response = await post(
      "https://fcm.googleapis.com/fcm/send",
      headers: {
        "Authorization":
            "key=AAAA0FgIGUk:APA91bEafq7yj9atAtpLymyQUfN-wYn2SEqcwa8SdjBBWqN2SFwUydYg4urIzQhaPQZ_W_ZcrGxsnESMs4EUonXes14eFC60WHxE9tK7s7GUS3fw6cyTQZ2NkEtoF0ynXLllZkCvhdMP",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "registration_ids": [
          dataRequestJemput?.konsumen?.user?.firebaseToken ??
              dataRequestAntar?.konsumen?.user?.firebaseToken
        ],
        "notification": {
          "title": "Chat baru",
          "body": msg,
          "click_action": "FLUTTER_NOTIFICATION_CLICK",},
        "data": {
          "id_sender": dataRequestJemput?.idKurir ?? dataRequestAntar?.idKurir,
          "id_order": isJemputRequest
              ? dataRequestJemput.idJemput
              : dataRequestAntar.idAntar,
          "body": msg,
        }
      }),
    );
    print(response.body);

  }
  // }

  Future<void> getChats() async {

    isJemputRequest = (dataRequestJemput != null) ? true : false;
    streamChatAdded = db
        .reference()
        .child("message")
        .child(isJemputRequest ? "jemput" : "antar")
        .child(
            "${isJemputRequest ? dataRequestJemput.idJemput : dataRequestAntar.idAntar}")
        .onChildAdded
        .listen((event) {
      setState(() {
        chats.add(Chat.fromSnapshot(event.snapshot));
        // chats.forEach((element) {log(element.message);});
      });

    });
    _scrollToBottom();
  }

  @override
  void initState() {
    namaKonsumen = dataRequestJemput?.namaKonsumen?.toString() ??
        dataRequestAntar?.namaKonsumen?.toString();
    getChats();

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    streamChatAdded?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$namaKonsumen'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 70,
            child: Container(
              child: ListView.builder(
                controller: _controller,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  bool isOpponent = false;

                  var date = DateTime.fromMillisecondsSinceEpoch(chats[index].time);
                  var formattedDate = DateFormat.yMMMMd().add_Hm().format(date); // Apr 8, 2020
                  print("idSender = ${chats[index].idSender.toString()}");
                  print("idJemput/antar = ${dataRequestJemput?.idKurir?.toString() ??
                      dataRequestAntar?.idKurir?.toString()}");
                  if(dataRequestJemput != null){
                    print("data jemput yang dikirim");
                  } else {
                    print("data antar yang dikirim");
                    print("isOpponent : $isOpponent");
                  }

                  if (chats[index]?.idSender?.toString() !=
                      (dataRequestJemput?.idKurir?.toString() ??
                      dataRequestAntar?.idKurir?.toString())) {
                    isOpponent = true;

                  }

                  if (isOpponent) {

                    return receiverWidget(chats[index].message,namaKonsumen,formattedDate);

                  } else {
                    // return receiverWidget(chats[index].message,namaKonsumen,formattedDate);
                    return senderWidget(chats[index].message);
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(high,0,0,0),
                      child: TextFormField(
                        controller: message,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,high,0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        if (message.text.trim().isNotEmpty) {
                          var buffer = message.text.trim();
                          message.clear();
                          await sendMessage(buffer);
                          _scrollToBottom();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
