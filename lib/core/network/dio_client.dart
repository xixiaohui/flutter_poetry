import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

/// Dio HTTP 客户端单例 — 统一管理所有网络请求配置
final class DioClient {
  DioClient._();

  static final Dio _poetryDio = _createPoetryDio();
  static final Dio _deepseekDio = _createDeepseekDio();

  /// 诗词 API 客户端
  static Dio get poetry => _poetryDio;

  /// DeepSeek AI API 客户端
  static Dio get deepseek => _deepseekDio;

  static Dio _createPoetryDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.poetryBaseUrl,
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

  static Dio _createDeepseekDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.deepseekBaseUrl,
      connectTimeout: ApiConstants.deepseekConnectTimeout,
      receiveTimeout: ApiConstants.deepseekReceiveTimeout,
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
