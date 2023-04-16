import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw9_delivery_app/app/core/config/env/env.dart';
import 'package:dw9_delivery_app/app/core/rest_client/interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  late final AuthInterceptor _authInterceptor;

  CustomDio()
      : super(BaseOptions(
            baseUrl: Env.instance['backend_base_url'] ?? '',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 60000))) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
    ));
    _authInterceptor = AuthInterceptor();
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
