import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

/// Dio HTTP 客户端单例 — 统一指向 Poetry Gateway
final class DioClient {
  DioClient._();

  static final Dio _instance = _createDio();

  /// 共享 Dio 实例
  static Dio get instance => _instance;

  static Dio _createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.gatewayBaseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      LogInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }
}

/// 错误拦截器 — 统一错误处理
final class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          message: '网络连接超时，请检查网络后重试',
          error: err.error,
          stackTrace: err.stackTrace,
        );
      case DioExceptionType.connectionError:
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          message: '网络不可用，请检查网络连接',
          error: err.error,
          stackTrace: err.stackTrace,
        );
      default:
        break;
    }
    handler.next(err);
  }
}
