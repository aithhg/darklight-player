import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../shared/widgets/video_card.dart';
import 'search_store.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = TextEditingController();
  SearchStore? _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_store == null) {
      final sp = context.read<ServiceProvider>();
      _store = SearchStore(sp.sourceRegistry);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                hintText: '搜索视频...',
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppTheme.textTertiary),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear_rounded,
                      color: AppTheme.textTertiary),
                  onPressed: () {
                    _controller.clear();
                    _store?.clear();
                  },
                ),
              ),
              onSubmitted: (value) => _store?.search(value),
            ),
          ),
          const SizedBox(height: 24),
          // Results
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_store == null) return const SizedBox.shrink();

    return Observer(
      builder: (_) {
        final store = _store!;

        if (store.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.accent),
          );
        }

        if (store.error != null) {
          return Center(
            child: Text(store.error!,
                style: const TextStyle(color: AppTheme.error)),
          );
        }

        if (store.results.isEmpty && store.query.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off_rounded,
                    size: 64,
                    color: AppTheme.textTertiary.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text('未找到 "${store.query}" 的相关结果',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textTertiary.withValues(alpha: 0.6))),
              ],
            ),
          );
        }

        if (store.results.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_rounded,
                    size: 64,
                    color: AppTheme.textTertiary.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text('输入关键词开始搜索',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.textTertiary.withValues(alpha: 0.6))),
              ],
            ),
          );
        }

        // Grid of results
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            childAspectRatio: 0.55,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
          ),
          itemCount: store.results.length,
          itemBuilder: (context, index) {
            final item = store.results[index];
            return VideoCard(
              title: item.title,
              subtitle: item.sourceName,
              imageUrl: item.imageUrl,
              badge: item.remarks,
              onTap: () => context.push(
                '/detail/${item.sourceName}/${item.videoId}',
              ),
            );
          },
        );
      },
    );
  }
}
