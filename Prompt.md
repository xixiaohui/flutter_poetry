# Flutter Poetry V2.0 -- Claude Code Prompt

> 目标：打造一款以 iOS 体验为核心、达到 App Store Today
> 推荐品质的现代中国古诗词应用。
> 内容来源api： https://github.com/palemoky/chinese-poetry-api.git


## 产品定位

不是诗词查询工具，而是沉浸式诗词阅读、收藏、分享、AI赏析平台。

## 核心原则

-   iOS First
-   Human Interface Guidelines 优先
-   Swift 风格动画体验（Flutter 实现）
-   Material 3 + Cupertino 混合设计
-   120FPS 优先，零卡顿

## 技术栈

Flutter
Stable、Riverpod、go_router、Dio、Freezed、Isar、FlexColorScheme、
flutter_animate、google_fonts、dynamic_color、share_plus、screenshot、
flutter_native_splash、flutter_launcher_icons。

## 模块

1.  首页：首页推荐、每日一句、专题推荐、节气、最近阅读。
2.  发现：唐诗、宋词、楚辞、飞花令、山水、送别等。
3.  搜索：全文、作者、标题、拼音、历史、热门。
4.  详情：正文、译文、注释、赏析、AI赏析、相关推荐。
5.  作者：生平、代表作、时间轴、地图。
6.  收藏：本地+云同步预留。
7.  分享：1080×1920 海报。
8.  设置：字体、主题、通知、阅读模式。

## iOS体验重点

-   自定义 NavigationBar（大标题折叠）
-   Hero 转场
-   Shared Axis
-   Interactive Pop Gesture
-   Haptic Feedback
-   Context Menu
-   Swipe Actions
-   Blur / Vibrancy
-   SF Symbols 风格图标
-   Dynamic Island / Live Activity 预留
-   深色模式精调

## UI规范

-   16pt 栅格
-   超大留白
-   卡片圆角20
-   毛玻璃
-   柔和阴影
-   中文阅读宽度限制
-   支持动态字体

- UI参考：https://github.com/VoltAgent/awesome-design-md.git

## 动画

页面切换、Hero、Fade、Scale、Parallax、Sliver、Skeleton Loading。
禁止默认 CircularProgressIndicator。

## Repository

API→Service→Repository→Riverpod→UI。 禁止 UI 直接访问网络。

## 代码规范

-   文件\<400行
-   Widget\<300行
-   禁止 setState
-   严格分层
-   每完成模块均确保可运行

## V2特色

-   AI赏析
-   AI配图
-   每日一句
-   飞花令
-   节气诗词
-   长图分享
-   阅读统计
-   离线阅读
-   收藏同步接口预留

V2.0 功能规划
- AI 赏析（接入 GPT/DeepSeek）
- 每日一句（首页 Widget）
- 诗词朗读（TTS）
- 诗词海报生成（适合社交分享）
- 飞花令挑战
- 诗词接龙
- 名句卡片（Instagram / 小红书 风格）
- AI 配图（每首诗自动生成国风插画）
- 收藏夹同步（Supabase/Firebase）
- 阅读统计（连续打卡、阅读时长）
- 今日节气 + 对应诗词
- 地图模式（诗人与创作地点可视化）
- 朝代时间轴
- 诗词分类浏览（边塞、山水、送别、咏物等）
- 离线数据库（首次下载后可完全离线阅读）

## 开发阶段

Phase1：基础架构 Phase2：首页/详情 Phase3：搜索/收藏 Phase4：分享/AI
Phase5：性能优化与发布

## Claude要求

持续保持统一架构，不重构已完成模块；所有输出均为可直接运行代码；遵循
Flutter 官方最佳实践。
