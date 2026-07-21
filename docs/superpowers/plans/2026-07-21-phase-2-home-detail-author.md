# Phase 2: Home + Detail + Author — Implementation Plan

## Context

Phase 1 delivered the complete foundation: Flutter project, design system (Apple + 国风), Freezed data models, API clients (REST + GraphQL + DeepSeek), Isar offline database, Service/Repository layers with Riverpod, go_router with 5-tab StatefulShellRoute, shared widgets (Skeleton, Glass, PoetryCard), app entry with splash.

Phase 2 now builds the first real user-facing pages: Home, Poem Detail, Author, and the AI Appreciation integration.

## Architecture

All data access follows the established layered pattern:
```
UI (Riverpod Consumer) → Provider → Repository → Service → API Client / Isar
```

New feature files go under `lib/features/<name>/` with `providers/` and `widgets/` subdirectories. Shared widgets go in `lib/shared/widgets/`. Each file ≤ 400 lines, each widget ≤ 300 lines. No `setState` (Riverpod only). No `CircularProgressIndicator` (SkeletonLoader only).

---

## Task 0: Data Layer — Add detail endpoints

**Why:** No `getPoemById` or `getAuthorById` exist. Detail pages need per-ID lookups.

**Files to modify:**
- `lib/core/constants/api_constants.dart` — add `poemDetailEndpoint`, `authorDetailEndpoint`
- `lib/data/api/poetry_api_client.dart` — add `getPoemById(String id)`, `getAuthorById(String id)`, `getPoemsByAuthor(String authorId)`
- `lib/data/services/poem_service.dart` — add `getPoemById` (API-first, cache to PoemDetailCache), `getPoemsByAuthor`
- `lib/data/services/author_service.dart` — add `getAuthorById`
- `lib/data/repositories/poem_repository.dart` — add `getPoemById`, `getPoemsByAuthor`
- `lib/data/repositories/author_repository.dart` — add `getAuthorById`
- Run build_runner to regenerate `.g.dart` files

---

## Task 1: Solar Term Calculator

**File:** `lib/core/utils/solar_term_calculator.dart` (~100 lines, pure Dart)

24 solar terms computed via astronomical formula (ecliptic longitude). Static methods: `current()` returns name + date + description.

---

## Task 2: Shared Widgets for Phase 2

**Files (4 new, 1 modified):**

| Widget | File | Purpose |
|--------|------|---------|
| `SectionHeader` | `lib/shared/widgets/section_header.dart` | Title + optional "See All" action |
| `AuthorChip` | `lib/shared/widgets/author_chip.dart` | Tappable author name chip |
| `DynastyBadge` | `lib/shared/widgets/dynasty_badge.dart` | Dynasty label badge |
| `ExpandableSection` | `lib/shared/widgets/expandable_section.dart` | Collapsible content with animated chevron |
| Update `PoetryCard` | `lib/shared/widgets/poetry_card.dart` | Add optional `heroTag` parameter for Hero transitions |

---

## Task 3: Home Page Providers

**File:** `lib/features/home/providers/home_providers.dart` (~180 lines)

Riverpod providers using `@riverpod` annotation:
- `homeRecommendationsProvider` — AsyncNotifier, paginated infinite scroll
- `dailyPoemProvider` — FutureProvider, date-seeded random poem
- `solarTermProvider` — sync provider using SolarTermCalculator
- `recentReadsProvider` — FutureProvider, last 10 readings from Isar

Run build_runner after creating.

---

## Task 4: Home Page Widgets

**Files (6 files in `lib/features/home/`):**

| Widget | File | Key Features |
|--------|------|-------------|
| `HomeSliverHeader` | `widgets/home_sliver_header.dart` | SliverAppBar, collapsing large title "诗词" |
| `DailyPoemCard` | `widgets/daily_poem_card.dart` | Glass effect, Hero tag `poem_${id}`, tap → detail |
| `SolarTermBanner` | `widgets/solar_term_banner.dart` | Current 节气 display, decorative accent |
| `RecentReadsShelf` | `widgets/recent_reads_shelf.dart` | Horizontal list, empty state "暂无阅读记录" |
| `RecommendationsGrid` | `widgets/recommendations_grid.dart` | SliverList + PoetryCard, infinite scroll, pull-to-refresh |
| `HomePage` | `home_page.dart` | ConsumerWidget, CustomScrollView orchestrating all slivers |

---

## Task 5: Poem Detail Providers

**File:** `lib/features/poem_detail/providers/poem_detail_providers.dart` (~160 lines)

- `poemDetailProvider(poemId)` — FutureProvider.family, fetch by ID
- `poemFavoriteProvider(poemId)` — AsyncNotifier, toggle + state
- `aiAppreciationProvider(poemId)` — FutureProvider.family, lazy-triggered (not watched on build)
- `relatedPoemsProvider(poemId)` — FutureProvider.family, same category/author
- `recordReadingProvider(poem)` — side-effect on page open

Run build_runner after creating.

---

## Task 6: Poem Detail Widgets

**Files (6 files in `lib/features/poem_detail/`):**

| Widget | File | Key Features |
|--------|------|-------------|
| `PoemContentView` | `widgets/poem_content_view.dart` | Noto Serif SC 20/28, max width 680pt, SelectableText |
| `PoemMetadataBar` | `widgets/poem_metadata_bar.dart` | Hero title, AuthorChip → author page, DynastyBadge |
| `PoemActionBar` | `widgets/poem_action_bar.dart` | Favorite (haptic), share placeholder, copy |
| `AiAppreciationSection` | `widgets/ai_appreciation_section.dart` | Button → shimmer → fade-in result, error+retry |
| `RelatedPoemsSection` | `widgets/related_poems_section.dart` | Compact PoetryCard list, skeleton loading |
| `PoemDetailPage` | `poem_detail_page.dart` | ConsumerWidget, SingleChildScrollView, all sections + loading/error states |

---

## Task 7: Author Page Providers

**File:** `lib/features/author/providers/author_providers.dart` (~100 lines)

- `authorDetailProvider(authorId)` — FutureProvider.family
- `authorMasterpiecesProvider(authorId)` — FutureProvider.family, search by author name

Run build_runner after creating.

---

## Task 8: Author Page Widgets

**Files (6 files in `lib/features/author/`):**

| Widget | File | Key Features |
|--------|------|-------------|
| `AuthorHeader` | `widgets/author_header.dart` | SliverAppBar, parallax portrait, name + dynasty + courtesy/pseudonym |
| `AuthorBiography` | `widgets/author_biography.dart` | SectionHeader + body text, hidden if null |
| `AuthorMasterpieces` | `widgets/author_masterpieces.dart` | PoetryCard list, tap → detail, empty state |
| `AuthorTimeline` | `widgets/author_timeline.dart` | Vertical timeline with dynasty period |
| `AuthorBirthplaceMap` | `widgets/author_birthplace_map.dart` | Location pin + text (map deferred to Phase 4) |
| `AuthorPage` | `author_page.dart` | ConsumerWidget, CustomScrollView orchestrating all sections |

---

## Task 9: Router Integration

**File:** `lib/core/router/app_router.dart`

Replace 3 placeholder routes with real pages:
- `/home` → `HomePage()`
- `/home/poem/:id` → `PoemDetailPage(poemId: id)` (uses rootNavigatorKey for full-screen push)
- `/home/author/:id` → `AuthorPage(authorId: id)` (uses rootNavigatorKey for full-screen push)

Add missing `/daily-poem` route under Home branch.

---

## Task 10: Polish — Haptics, Dark Mode, Edge Cases

- HapticFeedback on favorite toggle and card taps
- Dark mode verification on all pages
- Error states: retry button on all error screens
- Empty states: graceful messages in all sections
- Final `flutter analyze` — must be 0 errors
- All skeleton loading states verified (zero CircularProgressIndicator)

---

## Task Order & Dependencies

```
T0 (data layer) → T1 (solar calc) → T2 (shared widgets)
                                        ↓
                         T3 (home providers) + T5 (detail providers) + T7 (author providers)
                                        ↓
                         T4 (home page) + T6 (detail page) + T8 (author page)
                                        ↓
                                  T9 (router integration)
                                        ↓
                                  T10 (polish)
```

T3+T5+T7 can run in parallel (all independent providers). T4+T6+T8 can run in parallel (all independent pages).

## Verification

1. `flutter analyze` — 0 errors
2. `flutter test` — all tests pass
3. Manual: Home page renders all 5 sections with skeleton → data
4. Manual: Home → tap poem → Poem Detail with Hero transition
5. Manual: Detail → tap author chip → Author page with Hero/parallax
6. Manual: AI Appreciation button triggers shimmer → text fade-in
7. Manual: Favorite toggle persists across app restart
8. Manual: Dark mode toggle → all 3 pages render correctly
9. Manual: Pull-to-refresh on home, infinite scroll triggers load-more
10. Manual: Recent reads updates after visiting poem detail
