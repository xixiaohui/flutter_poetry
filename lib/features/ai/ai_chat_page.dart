import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../auth/providers/auth_providers.dart';
import 'providers/ai_providers.dart';

/// AI 诗词问答页
///
/// 需要登录才能使用。可传入 [poemTitle] 显示关联上下文标签，
/// 以及 [initialContext] 作为 AI 请求的附带上下文。
class AiChatPage extends ConsumerStatefulWidget {
  /// 随问题发送给 AI 的额外上下文（如诗词原文/赏析）
  final String? initialContext;

  /// 关联的诗词名，不为 null 时页面顶部显示关联标签
  final String? poemTitle;

  const AiChatPage({super.key, this.initialContext, this.poemTitle});

  @override
  ConsumerState<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends ConsumerState<AiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    ref.read(aiChatProvider.notifier).send(
          text,
          context: widget.initialContext,
        );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurfacePrimary : AppColors.surfacePrimary;
    final ink = isDark ? AppColors.darkInkPrimary : AppColors.inkPrimary;

    // 当消息列表更新时自动滚到底部
    ref.listen(aiChatProvider, (_, __) => _scrollToBottom());

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: ink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'AI 诗词问答',
          style: AppTypography.captionRegular(context)
              .copyWith(color: isDark ? AppColors.darkInkSecondary : AppColors.inkSecondary),
        ),
        centerTitle: true,
      ),
      body: isLoggedIn
          ? _buildChat(context, isDark)
          : _buildNotLoggedIn(context, isDark),
    );
  }

  Widget _buildNotLoggedIn(BuildContext context, bool isDark) {
    final inkTertiary = isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline, size: 64, color: inkTertiary),
          const SizedBox(height: AppSpacing.md),
          Text(
            '请先登录以使用 AI 问答',
            style: AppTypography.bodyMedium(context).copyWith(color: inkTertiary),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('返回'),
          ),
        ],
      ),
    );
  }

  Widget _buildChat(BuildContext context, bool isDark) {
    final messages = ref.watch(aiChatProvider);

    return Column(
      children: [
        if (widget.poemTitle != null)
          _ContextBar(poemTitle: widget.poemTitle!, isDark: isDark),
        Expanded(
          child: messages.isEmpty
              ? _buildEmptyState(context, isDark)
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _ChatBubble(
                      isUser: msg.isUser,
                      text: msg.text,
                      isDark: isDark,
                    );
                  },
                ),
        ),
        _buildInputBar(context, isDark),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    final inkTertiary = isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline, size: 48, color: inkTertiary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '输入您的问题，开始 AI 诗词问答',
            style: AppTypography.bodyMedium(context).copyWith(color: inkTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, bool isDark) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary,
          border: Border(
            top: BorderSide(
              color: isDark ? AppColors.darkSurfaceTertiary : AppColors.surfaceTertiary,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: '输入您的问题...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            IconButton.filled(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, size: 18),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

/// 关联上下文标签栏 — 显示当前关联的诗词名
class _ContextBar extends StatelessWidget {
  final String poemTitle;
  final bool isDark;

  const _ContextBar({required this.poemTitle, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary;
    final inkSec = isDark ? AppColors.darkInkSecondary : AppColors.inkSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      color: bg,
      child: Row(
        children: [
          Icon(Icons.menu_book, size: 16, color: inkSec),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '关联: $poemTitle',
            style: AppTypography.captionRegular(context).copyWith(color: inkSec),
          ),
        ],
      ),
    );
  }
}

/// 聊天气泡 — 支持用户（右对齐）和 AI（左对齐）两种样式
class _ChatBubble extends StatelessWidget {
  final bool isUser;
  final String text;
  final bool isDark;

  const _ChatBubble({
    required this.isUser,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isUser
        ? AppColors.accentPrimary
        : (isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary);
    final textColor = isUser
        ? Colors.white
        : (isDark ? AppColors.darkInkPrimary : AppColors.inkPrimary);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
                bottomRight: isUser ? Radius.zero : const Radius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: AppTypography.bodyMedium(context).copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
