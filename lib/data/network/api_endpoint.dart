import 'package:global_configuration/global_configuration.dart';

final String rootUrl = GlobalConfiguration().get("rootUrl").toString();
final String baseUrl = "$rootUrl" + "/api";
final String LOGIN_URL = "$baseUrl/login";
final String SET_FIREBASE_URL = "$baseUrl/user/set_firebase_token/";
final String NOTIFICATION_URL = "$baseUrl/notification/getNotif";
final String APP_CONFIG_URL = '$baseUrl/app_config';
final String SEARCH_DATA_CONSUMER_URL = "$baseUrl/konsumen/getData";
final String SERVICE_KILOS_URL = "$baseUrl/service_kiloan/getData";
final String SERVICE_SATUAN_URL = "$baseUrl/service_satuan/getData";
final String GET_PARFUME_URL = "$baseUrl/parfum/getData?filter=&is_active=ALL";
final String CREATE_LAUNDRY_URL = "$baseUrl/laundry/create";
final String CREATE_CONSUMER_URL = "$baseUrl/konsumen/create";
final String GET_DATA_ORDER_URL = "$baseUrl/laundry/getData?status_pengambilan";
final String GET_DETAIL_LAUNDRY = "$baseUrl/laundry/getData";
final String SET_COMPLETE_LAUNDRY_URL = "$baseUrl/laundry/update_status/";
final String SET_CANCEL_LAUNDRY_URL = "$baseUrl/laundry/cancel/";
final String GET_PENGELUARAN_URL = "$baseUrl/pengeluaran/getData";
final String GET_DATA_REQUEST_JEMPUT_URL = "$baseUrl/request_jemput/getData";
final String GET_DATA_REQUEST_ANTAR_URL = "$baseUrl/request_antar/getData";
final String UPDATE_DATA_REQUEST_JEMPUT_URL = "$baseUrl/request_jemput/update/";
final String UPDATE_DATA_REQUEST_ANTAR_URL = "$baseUrl/request_antar/update/";
final String GET_CEK_NUMBER_URL = "$baseUrl/cek_user/";
final String UPDATE_USER = "$baseUrl/user_update/";

