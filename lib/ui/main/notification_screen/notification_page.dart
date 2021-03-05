import 'package:flutter/material.dart';
import 'package:malaundry_kurir_flutter/data/notification_model/notification_model.dart';
import 'package:malaundry_kurir_flutter/ui/config/export_config.dart';
import 'package:malaundry_kurir_flutter/utils/export_utils.dart';
import 'package:malaundry_kurir_flutter/utils/notification_handler.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  final NotificationHandler notif;

  const NotificationPage({Key key, this.notif}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => NotificationHandler(context))
      ],
      child: Consumer<NotificationHandler>(
        builder: (context, notifBloc, _) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text("Notification"),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await notifBloc.getNotif();
              return false;
            },
            child: Container(
              margin:
                  EdgeInsets.symmetric(vertical: normal, horizontal: normal),
              child: notifBloc.isLoading
                  ? circularProgressIndicator()
                  : notifBloc.listNotif.length == 0
                      ? notFoundDataStatus()
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: notifBloc.listNotif.length,
                          itemBuilder: (BuildContext context, int index) {
                            DataNotif data = notifBloc.listNotif[index];
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context, data.urlTo);
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Color(0xFF2F80ED).withOpacity(0.4),
                                    child: Image.asset(
                                        'assets/images/email_icon.png'),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${data.sendByName}",
                                        style: sansPro(
                                          fontWeight: data?.isRead != "1"
                                              ? FontWeight.w700
                                              : null,
                                        ),
                                      ),
                                      Text(
                                        "${formatDate(data?.createdAt, withTimes: true)}",
                                        style: sansPro(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text("${data?.title}",
                                      style: sansPro(fontSize: 11)),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
