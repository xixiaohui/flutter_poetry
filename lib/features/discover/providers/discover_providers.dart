import 'dart:convert';
import 'dart:developer' as dev;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/api_models.dart';
import '../../../data/services/discover_service.dart';
part 'discover_providers.g.dart';

const _cacheKey = 'discover_cache';
const _tag = 'Discover';

/// 发现页数据 — 缓存优先，先显缓存再后台刷新
@riverpod
class DiscoverPageDataNotifier extends _$DiscoverPageDataNotifier {
  @override
  DiscoverData? build() => null;

  Future<void> load() async {
    // 1. 先读缓存 — 有则立即渲染
    final cached = await _readCache();
    if (cached != null) {
      state = cached;
      dev.log(' 📦 缓存命中 — 体裁${cached.types.length} 朝代${cached.dynasties.length} 诗词${cached.recentPoems.length}', name: _tag);
    }

    // 2. 调 API
    try {
      dev.log(' 🌐 请求 API...', name: _tag);
      final data = await DiscoverService().getDiscover();
      dev.log(' ✅ 成功 — 体裁${data.types.length} 朝代${data.dynasties.length} 诗词${data.recentPoems.length}', name: _tag);
      state = data;
      _writeCache(data);
    } catch (e) {
      dev.log(' ❌ API 失败: $e', name: _tag);
      if (cached == null) {
        state = DiscoverData(recentPoems: [], dynasties: [], types: []);
      }
    }
  }
}

// ── 缓存读写 ──

Future<DiscoverData?> _readCache() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_cacheKey);
    if (json == null) return null;
    return DiscoverData.fromJson(jsonDecode(json) as Map<String, dynamic>);
  } catch (_) {
    return null;
  }
}

Future<void> _writeCache(DiscoverData data) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(_toJson(data)));
    dev.log(' 💾 缓存已更新', name: _tag);
  } catch (_) {}
}

Map<String, dynamic> _toJson(DiscoverData d) => {
  'recentPoems': d.recentPoems.map(_poemToJson).toList(),
  'dynasties': d.dynasties.map(_itemToJson).toList(),
  'types': d.types.map(_itemToJson).toList(),
};

Map<String, dynamic> _poemToJson(ApiPoem p) => {
  'id': p.id, 'title': p.title, 'content': p.content,
  'author': p.author, 'dynasty': p.dynasty, 'type': p.type,
};

Map<String, dynamic> _itemToJson(CategoryItem i) => {'id': i.id, 'name': i.name};
