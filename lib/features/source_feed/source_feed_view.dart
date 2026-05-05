import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../data/models/search_result.dart';
import '../../shared/widgets/video_card.dart';

class SourceFeedView extends StatefulWidget {
  final String sourceName;

  const SourceFeedView({super.key, required this.sourceName});

  @override
  State<SourceFeedView> createState() => _SourceFeedViewState();
}

class _SourceFeedViewState extends State<SourceFeedView> {
  List<SearchResult> _items = [];
  bool _loading = true;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_items.isEmpty) _loadFeed();
  }

  Future<void> _loadFeed() async {
    final sp = context.read<ServiceProvider>();
    final source = sp.sourceService.findSource(widget.sourceName);
    if (source == null) {
      setState(() {
        _error = '未找到数据源: ${widget.sourceName}';
        _loading = false;
      });
      return;
    }
    try {
      final items = await source.getHomeFeed();
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => context.pop(),
                color: AppTheme.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(widget.sourceName,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _loading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.accent))
                : _error != null
                    ? Center(
                        child: Text(_error!,
                            style:
                                const TextStyle(color: AppTheme.error)))
                    : _items.isEmpty
                        ? const Center(
                            child: Text('暂无内容',
                                style: TextStyle(
                                    color: AppTheme.textTertiary)))
                        : RefreshIndicator(
                            color: AppTheme.accent,
                            onRefresh: _loadFeed,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 180,
                                childAspectRatio: 0.55,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                final item = _items[index];
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
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
