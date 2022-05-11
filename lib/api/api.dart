import 'dart:async';
import "package:dio/dio.dart";

class Client {
  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors());
    // TODO: Set django url here
    _dio.options.baseUrl = "http://example.com/api";
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    // do something before request is sent
  }

  @override
  Future<dynamic> onError(DioError dioError,
      ErrorInterceptorHandler errorInterceptorHandler) async {
    // do something to error
  }

  @override
  Future<dynamic> onResponse(Response response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    // do something before response
  }
}
