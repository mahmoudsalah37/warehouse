import 'package:dio/dio.dart';

class DefaultController {
  final String baseUrl = 'https://team.alqamah.sa/rms-proto/public/api';
  var _headers = {
    'Cache-Control': 'no-cache',
    'Postman-Token': '<calculated when request is sent>',
    'Host': '<calculated when request is sent>',
    'User-Agent': 'PostmanRuntime/7.26.10',
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
  };
  Dio dio;
  DefaultController(this.path) {
    dio = Dio();
    dio.options = BaseOptions(
      followRedirects: false,
      baseUrl: baseUrl,
      // headers: _headers,
    );
  }

  final String path;
  Future<Response> getData() async {
    print(dio.options.baseUrl);
    final response =
        await dio.get('/$path');
    return response;
  }

  Future<Response> getDataById(int id) async {
    final response = await dio.get('/$path/$id');
    return response;
  }

  Future<Response> postData(Map<String, dynamic> data) async {
    final response = await dio.post('/$path', data: data);
    return response;
  }

  Future<Response> putData(String data) async {
    final response = await dio.put('/$path', data: data);
    return response;
  }

  Future<Response> deleteData(int id) async {
    final response = await dio.delete('$path', queryParameters: {'id': id});
    return response;
  }
}
