import 'dart:convert';

import 'package:dio/dio.dart';

class PenilaianRepo {
  static const String baseUrl = "http://192.168.31.158:8000/api";

  static Future store(Map<String, dynamic> req) async {
    try {
      var res = await Dio().post(
        '$baseUrl/penilaians',
        data: jsonEncode(req),
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 201) {
        return res.data;
      }
    } on DioException {
      return false;
    }
  }

  static Future hitung() async {
    try {
      var res = await Dio().get(
        '$baseUrl/hitung-saw',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (res.statusCode == 200) {
        return res.data;
      }
    } on DioException {
      return false;
    }
  }
}
