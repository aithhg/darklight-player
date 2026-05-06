import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import 'detail_store.dart';

class DetailView extends StatefulWidget {
  final String sourceName;
  final String videoId;

  const DetailView({
    super.key,
    required this.sourceName,
    required this.videoId,
  });

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  DetailStore? _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_store == null) {
      final sp = context.read<ServiceProvider>();
      _store = DetailStore(sp.sourceRegistry, sp.favoriteService, sp.downloadService);
      _store!.loadDetail(widget.sourceName, widget.videoId);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => store.loadDetail(
                      widget.sourceName, widget.videoId),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        final detail = store.detail;
        if (detail == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => context.pop(),
                color: AppTheme.textSecondary,
              ),
              const SizedBox(height: 16),
              // Hero: poster + info + episodes side by side
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: detail.imageUrl != null
                          ? Image.network(detail.imageUrl!,
                              width: 200, height: 300, fit: BoxFit.cover,
                              headers: const {
                                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                                'Referer': 'https://www.baidu.com/',
                              },
                              errorBuilder: (_, __, ___) => _posterPlaceholder())
                          : _posterPlaceholder(),
                    ),
                    const SizedBox(width: 24),
                    // Right side: info + episodes
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(detail.title,
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary)),
                          const SizedBox(height: 8),
                          _infoRow(detail),
                          const SizedBox(height: 16),
                          // Actions
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: detail.episodes.isNotEmpty
                                    ? () => context.push('/player', extra: {
                                        'sourceName': widget.sourceName,
                                        'videoId': widget.videoId,
                                        'episodeIndex': 0,
                                        'title': detail.title,
                                      })
                                    : null,
                                icon: const Icon(Icons.play_arrow_rounded,
                                    size: 20),
                                label: const Text('播放'),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton.icon(
                                onPressed: () => store.toggleFavorite(),
                                icon: Icon(
                                  store.isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: 18,
                                ),
                                label: Text(
                                    store.isFavorite ? '已收藏' : '收藏'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: store.isFavorite
                                      ? AppTheme.accent
                                      : AppTheme.textSecondary,
                                  side: BorderSide(
                                      color: store.isFavorite
                                          ? AppTheme.accent
                                          : AppTheme.border),
                                ),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton.icon(
                                onPressed: detail.episodes.isNotEmpty
                                    ? () => _showDownloadDialog(context, store)
                                    : null,
                                icon: const Icon(Icons.download_rounded,
                                    size: 18),
                                label: const Text('下载'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.textSecondary,
                                  side: const BorderSide(
                                      color: AppTheme.border),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Description
                          if (detail.description != null &&
                              detail.description!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.surface2,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _stripHtml(detail.description!),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                    height: 1.6),
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Episodes — horizontal scroll
                          if (detail.episodes.isNotEmpty) ...[
                            Text('选集 (${detail.episodes.length})',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary)),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: detail.episodes.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => context.push('/player',
                                        extra: {
                                          'sourceName': widget.sourceName,
                                          'videoId': widget.videoId,
                                          'episodeIndex': index,
                                          'title': detail.title,
                                        }),
                                    borderRadius: BorderRadius.circular(6),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 64),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppTheme.surface3,
                                        borderRadius:
                                            BorderRadius.circular(6),
                                        border: Border.all(
                                            color: AppTheme.border),
                                      ),
                                      child: Center(
                                        child: Text(
                                          detail.episodes[index].name,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: AppTheme.textPrimary),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDownloadDialog(BuildContext context, DetailStore store) {
    final detail = store.detail!;
    final selected = <int>{};
    String? estimateText;
    bool estimating = false;
    void Function(void Function())? dialogSetState;

    Future<void> doEstimate() async {
      if (selected.isEmpty) return;
      final sp = context.read<ServiceProvider>();
      final firstIndex = selected.first;
      if (firstIndex >= detail.episodes.length) return;
      final url = detail.episodes[firstIndex].url;
      final result = await sp.downloadService.estimateSize(url);
      dialogSetState?.call(() {
        estimating = false;
        if (selected.length == 1) {
          estimateText = result;
        } else {
          estimateText = '${selected.length} 集 | 单集: $result';
        }
      });
    }

    void triggerEstimate() {
      if (selected.isEmpty) {
        dialogSetState?.call(() { estimateText = null; estimating = false; });
        return;
      }
      dialogSetState?.call(() { estimateText = null; estimating = true; });
      doEstimate();
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          dialogSetState = setDialogState;
          return AlertDialog(
            backgroundColor: AppTheme.surface2,
            title: Text('选择下载集数 (${detail.episodes.length})',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary)),
            content: SizedBox(
              width: 420,
              height: 340,
              child: Column(
                children: [
                  // Select all / deselect all
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          if (selected.length == detail.episodes.length) {
                            selected.clear();
                          } else {
                            selected.addAll(
                                List.generate(detail.episodes.length, (i) => i));
                          }
                          setDialogState(() {});
                          triggerEstimate();
                        },
                        child: Text(
                          selected.length == detail.episodes.length
                              ? '取消全选'
                              : '全选',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Episode grid
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          detail.episodes.length,
                          (index) {
                            final isSelected = selected.contains(index);
                            return InkWell(
                              onTap: () {
                                if (isSelected) {
                                  selected.remove(index);
                                } else {
                                  selected.add(index);
                                }
                                setDialogState(() {});
                                triggerEstimate();
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                constraints:
                                    const BoxConstraints(minWidth: 64),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.accent.withValues(alpha: 0.2)
                                      : AppTheme.surface3,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.accent
                                        : AppTheme.border,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    detail.episodes[index].name,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isSelected
                                          ? AppTheme.accent
                                          : AppTheme.textPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Size estimate section
                  if (selected.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surface3,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: estimating
                          ? const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: AppTheme.accent),
                                ),
                                SizedBox(width: 8),
                                Text('正在估算大小...',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textTertiary)),
                              ],
                            )
                          : Row(
                              children: [
                                const Icon(Icons.storage_rounded,
                                    size: 14, color: AppTheme.textTertiary),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    estimateText ?? '点击估算',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: estimateText != null
                                          ? AppTheme.textSecondary
                                          : AppTheme.textTertiary,
                                    ),
                                  ),
                                ),
                                if (estimateText == null)
                                  TextButton(
                                    onPressed: triggerEstimate,
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text('估算',
                                        style: TextStyle(fontSize: 12)),
                                  ),
                              ],
                            ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('取消'),
              ),
              ElevatedButton(
                onPressed: selected.isEmpty
                    ? null
                    : () {
                        Navigator.pop(ctx);
                        final episodeIndices = selected.toList()..sort();
                        store.downloadEpisodes(episodeIndices);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('已添加 ${selected.length} 集到下载队列'),
                            backgroundColor: AppTheme.surface3,
                          ),
                        );
                      },
                child: const Text('确认下载'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _posterPlaceholder() {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.surface3,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child:
            Icon(Icons.movie_rounded, size: 48, color: AppTheme.textTertiary),
      ),
    );
  }

  Widget _infoRow(dynamic detail) {
    final parts = <String>[];
    if (detail.year != null && detail.year!.isNotEmpty) parts.add(detail.year!);
    if (detail.typeName != null && detail.typeName!.isNotEmpty) {
      parts.add(detail.typeName!);
    }
    if (detail.area != null && detail.area!.isNotEmpty) parts.add(detail.area!);
    parts.add('来源: ${widget.sourceName}');

    return Text(parts.join(' · '),
        style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary));
  }

  String _stripHtml(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();
  }
}
