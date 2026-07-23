import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/api_models.dart';
import '../../data/models/author.dart';
import '../../data/models/dynasty.dart';
import '../../data/models/poem.dart';
import '../../shared/widgets/poetry_card.dart';
import 'providers/search_providers.dart';

/// 搜索页 — 输入关键词、选择搜索类型、分页展示结果
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  String _searchType = 'all';

  static const _filterChips = <_FilterChipData>[
    _FilterChipData('全部', 'all'),
    _FilterChipData('标题', 'title'),
    _FilterChipData('内容', 'content'),
    _FilterChipData('作者', 'author'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref
          .read(searchResultsProvider(_searchQuery, type: _searchType).notifier)
          .loadMore();
    }
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final poemsAsync =
        ref.watch(searchResultsProvider(_searchQuery, type: _searchType));

    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索'),
      ),
      body: Column(
        children: [
          // 搜索输入框
          Padding(
            padding: AppSpacing.pagePadding.copyWith(
              bottom: AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: _onSearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _onSearch(_searchController.text),
                ),
                hintText: '输入关键词搜索诗词',
                filled: true,
                fillColor: AppColors.surfaceTertiary,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.buttonRadius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 搜索类型筛选
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: AppSpacing.pagePadding.copyWith(
                bottom: AppSpacing.xs,
                top: 0,
              ),
              children: _filterChips.map((chip) {
                final selected = _searchType == chip.value;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: FilterChip(
                    label: Text(chip.label),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _searchType = chip.value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // 搜索结果
          Expanded(
            child: _buildBody(poemsAsync),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(AsyncValue<List<ApiPoem>> poemsAsync) {
    // 未输入关键词时的初始状态
    if (_searchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.inkTertiary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '请输入关键词搜索诗词',
              style: AppTypography.bodyMedium(context).copyWith(
                color: AppColors.inkTertiary,
              ),
            ),
          ],
        ),
      );
    }

    return poemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium(context).copyWith(
              color: AppColors.error,
            ),
          ),
        ),
      ),
      data: (poems) {
        // 搜索无结果
        if (poems.isEmpty) {
          return Center(
            child: Text(
              '未找到相关诗词',
              style: AppTypography.bodyMedium(context).copyWith(
                color: AppColors.inkSecondary,
              ),
            ),
          );
        }

        // 结果列表
        return ListView.builder(
          controller: _scrollController,
          padding: AppSpacing.pagePadding.copyWith(
            top: 0,
          ),
          itemCount: poems.length,
          itemBuilder: (context, index) {
            final poem = poems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: PoetryCard(
                poem: _toPoem(poem),
                onTap: () => context.push('/search/poem/${poem.id}'),
              ),
            );
          },
        );
      },
    );
  }
}

/// 将 ApiPoem（API 扁平结构）转换为 Poem（UI 嵌套对象模型）
Poem _toPoem(ApiPoem p) {
  return Poem(
    id: p.id.toString(),
    title: p.title,
    content: p.content,
    author: AuthorBrief(
      id: '',
      name: p.author ?? '',
      dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
    ),
    dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
    category: PoemCategory.misc,
  );
}

class _FilterChipData {
  final String label;
  final String value;

  const _FilterChipData(this.label, this.value);
}
