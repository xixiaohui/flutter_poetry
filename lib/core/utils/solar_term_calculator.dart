/// 中国传统二十四节气计算器
/// 基于太阳黄经 (ecliptic longitude) 算法
///
/// 算法为简化近似：使用年度累积日数而非完整天文计算。
/// 在节气边界处可能有 ±1 天的偏差，对于诗词应用而言已足够。
abstract final class SolarTermCalculator {
  /// 24 节气名称，按黄经从 315° (立春) 开始排列
  static const List<String> _termNames = [
    '立春', '雨水', '惊蛰', '春分', '清明', '谷雨',
    '立夏', '小满', '芒种', '夏至', '小暑', '大暑',
    '立秋', '处暑', '白露', '秋分', '寒露', '霜降',
    '立冬', '小雪', '大雪', '冬至', '小寒', '大寒',
  ];

  /// 节气描述
  static const Map<String, String> _termDescriptions = {
    '立春': '春气始而建立，万物复苏',
    '雨水': '东风既解冻，散而为雨',
    '惊蛰': '春雷乍动，万物生机盎然',
    '春分': '昼夜平分，春色满园',
    '清明': '气清景明，万物皆显',
    '谷雨': '雨生百谷，清净明洁',
    '立夏': '万物至此皆长大',
    '小满': '物致于此小得盈满',
    '芒种': '有芒之谷可播种',
    '夏至': '日长之至，影短之至',
    '小暑': '暑为温热之气',
    '大暑': '炎热至极',
    '立秋': '秋者揫也，物于此而揫敛',
    '处暑': '暑气至此而止',
    '白露': '阴气渐重，露凝而白',
    '秋分': '昼夜平分，秋色平分',
    '寒露': '露气寒冷，将凝结也',
    '霜降': '气肃而凝，露结为霜',
    '立冬': '冬者终也，万物收藏',
    '小雪': '雨下而为寒气所薄',
    '大雪': '至此而雪盛也',
    '冬至': '日短之至，影长之至',
    '小寒': '寒气积聚而未极',
    '大寒': '寒气之逆极',
  };

  /// 获取当前节气名称与描述。
  ///
  /// 返回一个 record，包含 [name] 和 [description] 字段。
  static ({String name, String description}) current() {
    final index = _calculateTermIndex(DateTime.now());
    final name = _termNames[index];
    return (name: name, description: _termDescriptions[name]!);
  }

  /// 根据 [date] 获取节气名称与描述。
  static ({String name, String description}) forDate(DateTime date) {
    final index = _calculateTermIndex(date);
    final name = _termNames[index];
    return (name: name, description: _termDescriptions[name]!);
  }

  /// 基于日期计算节气索引 (0–23)。
  ///
  /// 以春分日 (黄经 0°) 为参考点：
  /// - 太阳黄经每天约移动 0.9856° (360° / 365.25)
  /// - 每个节气对应 15° 黄经增量
  ///
  /// 映射关系：黄经 315° → 立春 (索引 0)，黄经 0° → 春分 (索引 3)
  static int _calculateTermIndex(DateTime date) {
    // 归一化到日期粒度，避免时分秒影响天数计算
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final year = normalizedDate.year;

    // 当年的近似春分日 (3 月 20 日)
    final springEquinox = DateTime(year, 3, 20);

    // 距离春分的天数 (可为负)
    final daysFromEquinox = normalizedDate.difference(springEquinox).inDays;

    // 太阳黄经每天约移动 0.9856°
    // 计算当前近似黄经，归一化到 [0, 360)
    const degreesPerDay = 0.9856;
    const degreesPerTerm = 15.0;

    double eclipticLongitude = (daysFromEquinox * degreesPerDay) % 360;
    if (eclipticLongitude < 0) eclipticLongitude += 360;

    // 黄经 → 节气索引映射
    // 立春 (索引 0) 对应黄经 315°
    //   → correctedIndex = (eclipticLongitude + 45) ~/ 15  % 24
    //   验证：黄经 315° → (315 + 45) / 15 = 24 → 24 % 24 = 0 (立春)
    //         黄经   0° → (  0 + 45) / 15 =  3 →  3 % 24 = 3 (春分)
    final correctedIndex = ((eclipticLongitude + 45) ~/ degreesPerTerm).toInt() % 24;

    return correctedIndex;
  }
}
