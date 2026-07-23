import 'dart:async';

/// 全局认证事件总线 — 广播 401 事件给 UI 层
///
/// 用法:
/// - 监听: `AuthEventBus.onUnauthorized.listen((_) { ... })`
/// - 触发: `AuthEventBus.fireUnauthorized()`
final class AuthEventBus {
  AuthEventBus._();

  static final StreamController<void> _controller =
      StreamController<void>.broadcast();

  /// 收到 401 未授权响应时触发的流
  static Stream<void> get onUnauthorized => _controller.stream;

  /// 广播 401 事件，通知所有监听者（如 UI 层跳转登录页）
  static void fireUnauthorized() {
    _controller.add(null);
  }
}
