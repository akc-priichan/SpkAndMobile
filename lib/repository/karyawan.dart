import 'dart:convert';

import 'package:dio/dio.dart';

class KaryawanRepo {
  static const String baseUrl = "http://192.168.31.158:8000/api/karyawans";

  static Future store(Map<String, dynamic> req) async {
    try {
      var res = await Dio().post(baseUrl, data: jsonEncode(req));
      if (res.statusCode == 201) {
        return res.data;
      }
    } on DioException {
      return false;
    }
  }

  static Future update(Map<String, dynamic> req, int id) async {
    try {
      var res = await Dio().put(
        '$baseUrl/$id',
        data: jsonEncode(req),
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

  static Future destroy(int id) async {
    try {
      var res = await Dio().delete("$baseUrl/$id");
      if (res.statusCode == 204) {
        return res.data;
      }
    } on DioException {
      return false;
    }
  }

  static Future index() async {
    try {
      var res = await Dio().get(
        baseUrl,
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
