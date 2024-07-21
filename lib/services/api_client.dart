import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:users_list/constants/constant_params.dart';
import 'package:users_list/constants/end_points.dart';

class ApiClient {
  static const _baseUrl = EndPointsUrl.baseUrl;
  static const _connectionTimeout = 10000;
  static const _receiveTimeout = 10000;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: _connectionTimeout),
      receiveTimeout: const Duration(milliseconds: _receiveTimeout),
    ),
  );

  Dio? _instance;
  //method for getting dio instance
  Dio? getInstance() {
    _instance ??= createDioInstance();
    return _instance;
  }

  Dio? createDioInstance() {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //modify your request
    }, onResponse: (Response? response, handler) {
      if (response != null) {
        //on success it is getting called here
        return handler.next(response);
      } else {
        return;
      }
    }, onError: (DioException e, handler) async {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          //catch the 401 here} else {
          handler.next(e);
        }
      }
    }));
    return _dio;
  }

  Future<dynamic> get(String path, {dynamic queryParam}) async {
    try {
      var baseUrls = _baseUrl;
      Options options = Options(
        headers: await getHeaders(null),
      );
      baseUrls = baseUrls + path;
      Response response =
          await _dio.get(baseUrls, queryParameters: queryParam, options: options);
      var createResponse =  response.data;
      return createResponse; //response.data;
    } on DioException catch (e) {
      if(e.response == null || e.response?.statusCode == 401){
        return HashMap();
      } else {
        return e.response?.data as Map<String, dynamic>;
      }
    }
  }

  getHeaders(bool? isMultipart, {dynamic postData}) async {
    var header = {
      ConstantParams.contentType: (isMultipart != null && isMultipart)
          ? ConstantParams.multipartFormData
          : ConstantParams.applicationJson,
      ConstantParams.charset: ConstantParams.utf,
    };
    return header;
  }
}
