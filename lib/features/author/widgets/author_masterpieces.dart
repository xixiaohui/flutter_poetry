import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../shared/widgets/poetry_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/author_providers.dart';

/// 代表作品列表 — 加载中 / 空态 / 数据 三态
class AuthorMasterpieces extends ConsumerWidget {
  final String authorId;

  const AuthorMasterpieces({super.key, required this.authorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPoems = ref.watch(authorMasterpiecesProvider(authorId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '代表作品'),
        asyncPoems.when(
          loading: () => const Column(
            children: [
              PoetryCardSkeleton(),
              PoetryCardSkeleton(),
              PoetryCardSkeleton(),
            ],
          ),
          error: (error, _) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Center(
              child: Text(
                '加载失败',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          data: (poems) {
            if (poems.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Center(
                  child: Text('暂无作品收录'),
                ),
              );
            }
            return Column(
              children: poems
                  .map(
                    (poem) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: PoetryCard(
                        poem: poem,
                        heroTag: 'poem_${poem.id}',
                        onTap: () =>
                            context.push(AppRoutes.poemById(poem.id)),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
