import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import '../../data/models/favorite_item.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  List<FavoriteItem> _items = [];
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final sp = context.read<ServiceProvider>();
    final items = await sp.favoriteService.getAll();
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
          const Text('我的收藏',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary)),
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
          Icon(Icons.favorite_rounded,
              size: 64,
              color: AppTheme.textTertiary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text('暂无收藏',
              style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textTertiary.withValues(alpha: 0.6))),
          const SizedBox(height: 8),
          Text('在视频详情页可以添加收藏',
              style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textTertiary.withValues(alpha: 0.4))),
        ],
      ),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: AppTheme.accent,
      onRefresh: _loadFavorites,
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return _FavoriteTile(
            item: item,
            onTap: () => context.push(
              '/detail/${item.sourceName}/${item.videoId}',
            ),
            onRemove: () async {
              final sp = context.read<ServiceProvider>();
              await sp.favoriteService.remove(
                  item.videoId, item.sourceName ?? '');
              _loadFavorites();
            },
          );
        },
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final FavoriteItem item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteTile({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

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
                    Text(
                      [item.sourceName, item.typeName, item.remarks]
                          .where((s) => s != null && s.isNotEmpty)
                          .join(' · '),
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textTertiary),
                    ),
                    if (item.addedAt != null)
                      Text('收藏于 ${_formatDate(item.addedAt!)}',
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.textTertiary)),
                  ],
                ),
              ),
              // Remove
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 20, color: AppTheme.textTertiary),
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
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
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
