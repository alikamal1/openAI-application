import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class RemoteRepository{
  const RemoteRepository();

  Future postHttp(String message) async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var response = await dio.post('https://testapi-0b4e.onrender.com/api_request',
      queryParameters:{
        "prompt":message
      }
      );
      print(response);
      return response;
    } catch (e) {
      print(e.toString());
      Exception(e);
    }
  }
}