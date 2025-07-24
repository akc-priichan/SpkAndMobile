import 'dart:convert';

import 'package:absen_kantor/local_storage.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static const String baseUrl = "http://192.168.31.158:8000/api";
  static Future login(Map<String, dynamic> req) async {
    try {
      var res = await Dio().post("$baseUrl/login", data: jsonEncode(req));
      if (res.statusCode == 200) {
        LocalStorageService.saveUser(
          res.data['user']['id'].toString(),
          res.data['user']['name'],
        );
        return true;
      }
    } on DioException {
      return false;
    }
  }
}
