/// Isar 模型条件导出 — Web 使用桩避免 64-bit 编译错误
export 'isar_models_web.dart' if (dart.library.io) 'isar_models_real.dart';
