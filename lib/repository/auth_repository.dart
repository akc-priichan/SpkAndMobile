// import 'dart:convert';

// import 'package:dio/dio.dart';

// class AuthRepo {
//   static Future register(Map<String, dynamic> req) async {
//     try {
//       var res = await Dio().post(
//         "https://aplikasi-absen-eb6b0-default-rtdb.firebaseio.com",
//         data: jsonEncode(req),
//       );
//       if (res.statusCode == 200) {
//         return true;
//       }
//     } on DioError catch (e) {
//       return false;
//     }
//   }

//   static Future index() async {
//     try {
//       var res = await Dio()
//           .get("https://aplikasi-absen-eb6b0-default-rtdb.firebaseio.com");
//       if (res.statusCode == 200) {
//         return res.data;
//       }
//     } on DioError catch (e) {
//       return false;
//     }
//   }
// }
