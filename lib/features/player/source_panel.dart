import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../data/models/episode.dart';

class SourcePanel extends StatelessWidget {
  final List<Episode> episodes;
  final int currentEpisodeIndex;
  final Function(int) onEpisodeTap;

  const SourcePanel({
    super.key,
    required this.episodes,
    required this.currentEpisodeIndex,
    required this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: AppTheme.surface1,
        border: Border(
          left: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.border, width: 1),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.list_rounded,
                    size: 18, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                const Text(
                  '选集',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '${episodes.length} 集',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          // Episode list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                final episode = episodes[index];
                final isCurrent = index == currentEpisodeIndex;

                return InkWell(
                  onTap: () => onEpisodeTap(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? AppTheme.accentLight
                          : Colors.transparent,
                      border: Border(
                        left: BorderSide(
                          color:
                              isCurrent ? AppTheme.accent : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            episode.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  isCurrent ? FontWeight.w600 : FontWeight.w400,
                              color: isCurrent
                                  ? AppTheme.accent
                                  : AppTheme.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isCurrent)
                          const Icon(Icons.play_arrow_rounded,
                              size: 16, color: AppTheme.accent),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
