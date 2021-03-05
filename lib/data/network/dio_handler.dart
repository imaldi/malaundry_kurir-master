import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHandler {
  static BuildContext context;

  static void setContext(BuildContext context) {
    DioHandler.context = context;
  }

  static String parseDioErrorMessage(DioError e, StackTrace st) {
    String error;
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        error = e.message;
        break;
      case DioErrorType.SEND_TIMEOUT:
        error = e.message;
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        error = e.message;
        break;
      case DioErrorType.RESPONSE:
        error = e.message;
        break;
      case DioErrorType.CANCEL:
        error = e.message;
        break;
      case DioErrorType.DEFAULT:
        error = e.message;
        break;
    }

    return error;
  }
}
