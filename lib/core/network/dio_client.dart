import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_constants.dart';
import 'auth_event_bus.dart';

/// Dio HTTP 客户端单例 — 统一指向 Poetry Gateway
final class DioClient {
  DioClient._();

  static final Dio _instance = _createDio();

  /// 共享 Dio 实例
  static Dio get instance => _instance;

  /// SharedPreferences 中存储 JWT Token 的 key
  static const String tokenKey = 'auth_token';

  static Dio _createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      _AuthInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
      _ResponseParserInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }
}

/// 认证拦截器 — 每次请求自动注入 JWT Token
final class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(DioClient.tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

/// 响应解析拦截器 — 解析统一响应格式 `{success, data}`
final class _ResponseParserInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('success')) {
      if (data['success'] == true) {
        // 解包 data 字段
        final unwrapped = Response(
          requestOptions: response.requestOptions,
          data: data['data'],
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          headers: response.headers,
          extra: response.extra,
          isRedirect: response.isRedirect,
          redirects: response.redirects,
        );
        handler.resolve(unwrapped);
        return;
      } else {
        // success == false → 转为异常
        final code = data['code'] as String? ?? 'UNKNOWN_ERROR';
        final message = data['message'] as String? ?? '请求失败';
        final err = DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: message,
          error: code,
        );
        handler.reject(err);
        return;
      }
    }
    // 非标准格式，透传
    handler.next(response);
  }
}

/// 错误拦截器 — 中文错误提示 + 401 处理
final class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String? friendlyMessage;

    if (err.type == DioExceptionType.badResponse) {
      final statusCode = err.response?.statusCode;
      final data = err.response?.data;

      // 从响应体中提取业务错误码
      if (data is Map<String, dynamic> && data['code'] is String) {
        friendlyMessage = _mapCodeToMessage(data['code'] as String);
      }

      // HTTP 状态码 → 中文提示
      friendlyMessage ??= switch (statusCode) {
        400 => '请求参数错误',
        404 => '内容不存在',
        500 || 502 || 503 => '服务器繁忙，请稍后重试',
        _ => null,
      };

      // 401 未授权 → 清除 token + 广播事件
      if (statusCode == 401) {
        _handleUnauthorized();
      }
    }

    // 网络连接错误 → 中文提示
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        friendlyMessage ??= '网络连接超时，请检查网络后重试';
        break;
      case DioExceptionType.connectionError:
        friendlyMessage ??= '网络不可用，请检查网络连接';
        break;
      default:
        break;
    }

    if (friendlyMessage != null) {
      err = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        message: friendlyMessage,
        error: err.error,
        stackTrace: err.stackTrace,
      );
    }

    handler.next(err);
  }

  /// 将后端业务错误码映射为中文提示
  static String? _mapCodeToMessage(String code) {
    return switch (code) {
      'VALIDATION_ERROR' => '参数错误',
      'UNAUTHORIZED' => '请先登录',
      'NOT_FOUND' => '资源不存在',
      'RATE_LIMITED' => '请求太频繁',
      'UPSTREAM_ERROR' => '服务暂时不可用',
      _ => null,
    };
  }

  /// 处理 401: 清除本地 token 并广播未授权事件
  static void _handleUnauthorized() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(DioClient.tokenKey);
    });
    AuthEventBus.fireUnauthorized();
  }
}
