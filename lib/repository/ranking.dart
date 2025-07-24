import 'package:dio/dio.dart';

class RankingRepo {
  static const String baseUrl = "http://192.168.31.158:8000/api/rankings";

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
