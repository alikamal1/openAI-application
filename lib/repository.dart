import 'package:dio/dio.dart';

class RemoteRepository{
  const RemoteRepository();

  Future postHttp(String message) async {
    try {
      var response = await Dio().post('http://192.168.100.5:8000/api_request',
      queryParameters:{
        "prompt":message
      }
      );
      return response;
    } catch (e) {
      Exception(e);
    }
  }
}