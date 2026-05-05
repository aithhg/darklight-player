import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../shared/widgets/video_card.dart';
import '../../data/models/search_result.dart';
import 'home_store.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeStore? _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_store == null) {
      final sp = context.read<ServiceProvider>();
      _store = HomeStore(sp.sourceRegistry);
      _store!.loadFeeds();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_store == null) return const SizedBox.shrink();

    return Observer(
      builder: (_) {
        final store = _store!;

        if (store.isLoading && store.recommendations.isEmpty && store.genreSections.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.accent),
          );
        }

        if (store.error != null && store.recommendations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline_rounded,
                    size: 48, color: AppTheme.error),
                const SizedBox(height: 16),
                Text(store.error!,
                    style: const TextStyle(color: AppTheme.textSecondary)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => store.refresh(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppTheme.accent,
          onRefresh: () => store.refresh(),
          child: CustomScrollView(
            slivers: [
              // Personalized recommendations
              if (store.recommendations.isNotEmpty)
                SliverToBoxAdapter(
                  child: _RecommendationSection(items: store.recommendations),
                ),
              // Genre sections
              if (store.genreSections.isNotEmpty)
                ...store.genreSections.entries.map((entry) =>
                    SliverToBoxAdapter(
                      child: _GenreSection(
                        genre: entry.key,
                        items: entry.value,
                      ),
                    )),
              // Source feed sections
              if (store.feedSections.isNotEmpty)
                ...store.feedSections.entries.map((entry) =>
                    SliverToBoxAdapter(
                      child: _SourceSection(
                        sourceName: entry.key,
                        items: entry.value,
                      ),
                    )),
              // Empty state
              if (store.recommendations.isEmpty &&
                  store.genreSections.isEmpty &&
                  store.feedSections.isEmpty &&
                  !store.isLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(Icons.cloud_off_rounded,
                              size: 48, color: AppTheme.textTertiary),
                          const SizedBox(height: 16),
                          const Text('暂无内容',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.textSecondary)),
                          const SizedBox(height: 8),
                          const Text('下拉刷新或检查网络连接',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textTertiary)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => store.refresh(),
                            child: const Text('重新加载'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RecommendationSection extends StatelessWidget {
  final List<SearchResult> items;

  const _RecommendationSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppTheme.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.recommend_rounded,
                    size: 16, color: AppTheme.accent),
              ),
              const SizedBox(width: 10),
              const Text('为你推荐',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 16,
            children: items.map((item) => SizedBox(
              width: 160,
              height: 260,
              child: VideoCard(
                title: item.title,
                subtitle: item.typeName ?? item.sourceName,
                imageUrl: item.imageUrl,
                badge: item.remarks,
                onTap: () => context.push(
                  '/detail/${item.sourceName}/${item.videoId}',
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _GenreSection extends StatelessWidget {
  final String genre;
  final List<SearchResult> items;

  const _GenreSection({required this.genre, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(genre,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 16,
            children: items.map((item) => SizedBox(
              width: 160,
              height: 260,
              child: VideoCard(
                title: item.title,
                subtitle: item.typeName ?? item.year,
                imageUrl: item.imageUrl,
                badge: item.remarks,
                onTap: () => context.push(
                  '/detail/${item.sourceName}/${item.videoId}',
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _SourceSection extends StatelessWidget {
  final String sourceName;
  final List<SearchResult> items;

  const _SourceSection({required this.sourceName, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sourceName,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary)),
              TextButton(
                onPressed: () => context.push('/source-feed/$sourceName'),
                child: const Text('查看更多'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 16,
            children: items.take(20).map((item) => SizedBox(
              width: 160,
              height: 260,
              child: VideoCard(
                title: item.title,
                subtitle: item.sourceName,
                imageUrl: item.imageUrl,
                badge: item.remarks,
                onTap: () => context.push(
                  '/detail/${item.sourceName}/${item.videoId}',
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
