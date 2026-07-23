import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/api_models.dart';
import '../../data/repositories/stats_repository.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(readingStatsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('阅读统计')),
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            '加载失败：$err',
            style: const TextStyle(color: AppColors.error),
          ),
        ),
        data: (stats) => ListView(
          children: [
            // ── 总览卡片 ──
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: _OverviewCard(
                      label: '总阅读量',
                      value: stats.totalReads,
                      color: AppColors.accentPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OverviewCard(
                      label: '覆盖诗词',
                      value: stats.totalPoems,
                      color: AppColors.celadon,
                    ),
                  ),
                ],
              ),
            ),

            // ── 热门诗词 Top 10 ──
            const _SectionHeader(title: '热门诗词 Top 10'),
            ...stats.topPoems.take(10).toList().asMap().entries.map(
                  (entry) => _RankListTile(
                    rank: entry.key + 1,
                    label: entry.value.label,
                    count: entry.value.count,
                  ),
                ),

            const SizedBox(height: 8),

            // ── 热门作者 ──
            const _SectionHeader(title: '热门作者'),
            ...stats.topAuthors.take(10).map(
                  (item) => ListTile(
                    title: Text(item.label),
                    trailing: Text(
                      '${item.count} 次',
                      style: const TextStyle(
                        color: AppColors.inkSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

            const SizedBox(height: 8),

            // ── 近7日阅读趋势 ──
            const _SectionHeader(title: '近7日阅读趋势'),
            SizedBox(
              height: 160,
              child: _BarChart(dailyCounts: stats.readsByDay),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// 总览卡片
class _OverviewCard extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _OverviewCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: color.withAlpha(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: TextStyle(
                color: color,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 带排名的列表项
class _RankListTile extends StatelessWidget {
  final int rank;
  final String label;
  final int count;

  const _RankListTile({
    required this.rank,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final Color avatarColor =
        rank <= 3 ? AppColors.accentGold : AppColors.inkTertiary;

    return ListTile(
      leading: CircleAvatar(
        radius: 14,
        backgroundColor: avatarColor,
        child: Text(
          '$rank',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(label),
      trailing: Text(
        '$count 次',
        style: const TextStyle(
          color: AppColors.inkSecondary,
          fontSize: 14,
        ),
      ),
    );
  }
}

/// 柱状图
class _BarChart extends StatelessWidget {
  final List<DailyCount> dailyCounts;

  const _BarChart({required this.dailyCounts});

  @override
  Widget build(BuildContext context) {
    if (dailyCounts.isEmpty) {
      return const Center(
        child: Text(
          '暂无数据',
          style: TextStyle(color: AppColors.inkTertiary),
        ),
      );
    }

    final int maxCount =
        dailyCounts.map((d) => d.count).reduce((a, b) => a > b ? a : b);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: dailyCounts.map((item) {
          final double ratio =
              maxCount > 0 ? item.count / maxCount : 0.0;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${item.count}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.inkSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 120 * ratio,
                    decoration: BoxDecoration(
                      color: AppColors.accentPrimary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.date.length >= 5
                        ? item.date.substring(5)
                        : item.date,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.inkTertiary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.accentPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
}
