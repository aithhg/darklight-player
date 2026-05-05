import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../data/models/history_item.dart';
import '../../shared/utils/format_utils.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<HistoryItem> _items = [];
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final sp = context.read<ServiceProvider>();
    final items = await sp.historyService.getAll();
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('观看历史',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              if (_items.isNotEmpty)
                TextButton.icon(
                  onPressed: () async {
                    final sp = context.read<ServiceProvider>();
                    await sp.historyService.clear();
                    _loadHistory();
                  },
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  label: const Text('清空'),
                  style: TextButton.styleFrom(
                      foregroundColor: AppTheme.textTertiary),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _loading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppTheme.accent))
                : _items.isEmpty
                    ? _buildEmpty()
                    : _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded,
              size: 64,
              color: AppTheme.textTertiary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text('暂无观看记录',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textTertiary.withValues(alpha: 0.6))),
        ],
      ),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: AppTheme.accent,
      onRefresh: _loadHistory,
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return _HistoryTile(
            item: item,
            onTap: () {
              if (item.sourceName != null) {
                context.push(
                  '/detail/${item.sourceName}/${item.videoId}',
                );
              }
            },
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final HistoryItem item;
  final VoidCallback onTap;

  const _HistoryTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface2,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: item.imageUrl != null
                    ? Image.network(item.imageUrl!,
                        width: 60, height: 80, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _thumbPlaceholder())
                    : _thumbPlaceholder(),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary)),
                    const SizedBox(height: 4),
                    if (item.episodeName.isNotEmpty)
                      Text(item.episodeName,
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.accent)),
                    if (item.sourceName != null)
                      Text(item.sourceName!,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.textTertiary)),
                    if (item.duration > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: _buildProgressBar(),
                      ),
                  ],
                ),
              ),
              // Time
              if (item.watchedAt != null)
                Text(_formatDate(item.watchedAt!),
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textTertiary)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress =
        item.duration > 0 ? (item.position / item.duration).clamp(0.0, 1.0) : 0.0;
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.surface4,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppTheme.accent),
              minHeight: 3,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${FormatUtils.duration(item.position)} / ${FormatUtils.duration(item.duration)}',
          style: const TextStyle(fontSize: 11, color: AppTheme.textTertiary),
        ),
      ],
    );
  }

  Widget _thumbPlaceholder() {
    return Container(
      width: 60,
      height: 80,
      color: AppTheme.surface3,
      child: const Center(
        child: Icon(Icons.movie_rounded, size: 24, color: AppTheme.textTertiary),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return '今天';
    }
    return '${dt.month}/${dt.day}';
  }
}
