import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/config_repository.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authRepositoryProvider);
    final configAsync = ref.watch(appConfigProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          // ── 账户 ──
          const _SectionHeader(title: '账户'),
          authAsync.when(
            data: (user) {
              if (user == null) {
                return _SettingsTile(
                  icon: Icons.person_outline,
                  title: '登录 / 注册',
                  onTap: () => context.push(AppRoutes.login),
                );
              }
              return Column(
                children: [
                  _SettingsTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.accentPrimary,
                      child: Text(
                        (user.name ?? user.email)[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: user.name ?? '用户',
                    subtitle: user.email,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: AppColors.inkTertiary,
                    ),
                    onTap: () => context.push(AppRoutes.settingsProfile),
                  ),
                  _SettingsTile(
                    icon: Icons.logout,
                    title: '退出登录',
                    titleColor: AppColors.error,
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('确认退出'),
                          content: const Text('确定要退出登录吗？'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(dialogContext).pop(),
                              child: const Text('取消'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(authRepositoryProvider.notifier)
                                    .logout();
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text(
                                '退出',
                                style: TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => _SettingsTile(
              icon: Icons.person_outline,
              title: '登录 / 注册',
              onTap: () => context.push(AppRoutes.login),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── 阅读 ──
          const _SectionHeader(title: '阅读'),
          _SettingsTile(
            icon: Icons.text_fields,
            title: '字体设置',
            onTap: () => context.push(AppRoutes.fontSettings),
          ),
          _SettingsTile(
            icon: Icons.palette_outlined,
            title: '主题设置',
            onTap: () => context.push(AppRoutes.themeSettings),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── 数据 ──
          const _SectionHeader(title: '数据'),
          _SettingsTile(
            icon: Icons.bar_chart_outlined,
            title: '阅读统计',
            onTap: () => context.push(AppRoutes.stats),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── 关于 ──
          const _SectionHeader(title: '关于'),
          _SettingsTile(
            icon: Icons.info_outline,
            title: '版本',
            trailing: configAsync.when(
              data: (config) => Text(
                config.version,
                style: const TextStyle(color: AppColors.inkSecondary),
              ),
              loading: () => const Text(
                '...',
                style: TextStyle(color: AppColors.inkTertiary),
              ),
              error: (_, __) => const Text(
                '1.0.0',
                style: TextStyle(color: AppColors.inkSecondary),
              ),
            ),
          ),
        ],
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

class _SettingsTile extends StatelessWidget {
  final IconData? icon;
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;

  const _SettingsTile({
    this.icon,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ??
          (icon != null
              ? Icon(icon, color: AppColors.inkSecondary)
              : null),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? AppColors.inkPrimary,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                color: AppColors.inkTertiary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
