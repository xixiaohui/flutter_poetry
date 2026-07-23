import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/repositories/auth_repository.dart';

/// 登录/注册页 — 全屏模态，国风水墨风格。
///
/// TabBar 切换登录/注册模式，表单提交后自动 pop 返回。
/// 注册模式下显示可选昵称字段。
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _loading = false;

  bool get _isLogin => _tabController.index == 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final authRepo = ref.read(authRepositoryProvider.notifier);
      if (_isLogin) {
        await authRepo.login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        await authRepo.register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nicknameController.text.trim().isEmpty
              ? null
              : _nicknameController.text.trim(),
        );
      }
      if (mounted) context.pop();
    } catch (e) {
      if (!mounted) return;
      final message = e is DioException ? e.message : '操作失败，请重试';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? '请求失败')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── 红色印章 Logo ──
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.accentPrimary,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.cardRadius),
                    ),
                    child: const Center(
                      child: Text(
                        '诗',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '诗词',
                    style: AppTypography.displayLarge(context),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // ── TabBar: 登录 | 注册 ──
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.buttonRadius),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.accentPrimary,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.buttonRadius),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.inkSecondary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: '登录'),
                        Tab(text: '注册'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // ── 表单 ──
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: '邮箱',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return '请输入邮箱地址';
                            }
                            if (!value.contains('@')) {
                              return '请输入有效的邮箱地址';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: _isLogin
                              ? TextInputAction.done
                              : TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: '密码',
                            prefixIcon: Icon(Icons.lock_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return '密码至少需要6位字符';
                            }
                            return null;
                          },
                        ),
                        // 注册模式显示昵称字段
                        if (!_isLogin) ...[
                          const SizedBox(height: AppSpacing.md),
                          TextFormField(
                            controller: _nicknameController,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              labelText: '昵称',
                              hintText: '选填',
                              prefixIcon: Icon(Icons.person_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.xl),

                        // ── 提交按钮 ──
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton(
                            onPressed: _loading ? null : _submit,
                            child: _loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(_isLogin ? '登录' : '注册'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
