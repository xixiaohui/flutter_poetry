extension StringX on String {
  /// 截取指定长度，超出加省略号
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}…';
  }

  /// 判断是否为空白或空
  bool get isBlank => trim().isEmpty;

  /// 判断是否不为空白
  bool get isNotBlank => !isBlank;

  /// 安全转换为首字母大写的显示名称
  String get displayName {
    if (isBlank) return '';
    return trim();
  }
}
