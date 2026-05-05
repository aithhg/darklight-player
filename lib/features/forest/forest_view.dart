import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../data/models/search_result.dart';
import '../../shared/widgets/video_card.dart';

class ForestView extends StatefulWidget {
  const ForestView({super.key});

  @override
  State<ForestView> createState() => _ForestViewState();
}

class _ForestViewState extends State<ForestView> {
  List<SearchResult> _items = [];
  bool _loading = true;
  String? _error;
  int _page = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_items.isEmpty) _loadFeed();
  }

  Future<void> _loadFeed() async {
    final sp = context.read<ServiceProvider>();
    final source = sp.sourceService.findSource('森林资源');
    if (source == null) {
      setState(() {
        _error = '未找到森林资源数据源';
        _loading = false;
      });
      return;
    }
    try {
      final items = await source.getHomeFeed(page: _page);
      setState(() {
        if (_page == 1) {
          _items = items;
        } else {
          _items.addAll(items);
        }
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    _page++;
    await _loadFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.forest_rounded,
                    size: 20, color: Color(0xFF22C55E)),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Forest',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary)),
                  Text('森林资源 · 推荐影视内容',
                      style: TextStyle(
                          fontSize: 13, color: AppTheme.textTertiary)),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh_rounded,
                    color: AppTheme.textSecondary),
                onPressed: () {
                  setState(() {
                    _page = 1;
                    _loading = true;
                    _items.clear();
                  });
                  _loadFeed();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Content
          Expanded(
            child: _loading && _items.isEmpty
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.accent))
                : _error != null && _items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cloud_off_rounded,
                                size: 48, color: AppTheme.textTertiary),
                            const SizedBox(height: 12),
                            Text(_error!,
                                style: const TextStyle(
                                    color: AppTheme.textSecondary)),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _loading = true;
                                  _error = null;
                                });
                                _loadFeed();
                              },
                              child: const Text('重试'),
                            ),
                          ],
                        ),
                      )
                    : _buildGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return RefreshIndicator(
      color: AppTheme.accent,
      onRefresh: () async {
        _page = 1;
        _loading = true;
        _items.clear();
        await _loadFeed();
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 0.55,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: _items.length + 1, // +1 for load more
        itemBuilder: (context, index) {
          if (index == _items.length) {
            // Load more button
            return Center(
              child: _loading
                  ? const CircularProgressIndicator(
                      color: AppTheme.accent, strokeWidth: 2)
                  : TextButton(
                      onPressed: _loadMore,
                      child: const Text('加载更多'),
                    ),
            );
          }

          final item = _items[index];
          return VideoCard(
            title: item.title,
            subtitle: item.typeName ?? item.year,
            imageUrl: item.imageUrl,
            badge: item.remarks,
            onTap: () => context.push(
              '/detail/森林资源/${item.videoId}',
            ),
          );
        },
      ),
    );
  }
}
