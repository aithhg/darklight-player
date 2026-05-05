import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'player_controller.dart';

class PlayerControls extends StatelessWidget {
  final PlayerController controller;
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onPreviousEpisode;
  final VoidCallback? onNextEpisode;

  const PlayerControls({
    super.key,
    required this.controller,
    required this.title,
    this.onBack,
    this.onPreviousEpisode,
    this.onNextEpisode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.7),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withValues(alpha: 0.7),
          ],
          stops: const [0, 0.3, 0.7, 1],
        ),
      ),
      child: Column(
        children: [
          _buildTopBar(),
          const Spacer(),
          _buildCenterControls(),
          const Spacer(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: onBack,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 36),
          onPressed: () => controller.skipBackward(seconds: 10),
        ),
        const SizedBox(width: 24),
        IconButton(
          icon: Icon(
            controller.isPlaying
                ? Icons.pause_circle_filled_rounded
                : Icons.play_circle_filled_rounded,
            color: Colors.white,
            size: 64,
          ),
          onPressed: () => controller.togglePlay(),
        ),
        const SizedBox(width: 24),
        IconButton(
          icon: const Icon(Icons.forward_10_rounded, color: Colors.white, size: 36),
          onPressed: () => controller.skipForward(seconds: 10),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppTheme.accent,
              inactiveTrackColor: AppTheme.surface4,
              thumbColor: AppTheme.accent,
              overlayColor: AppTheme.accentLight,
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: controller.position,
              max: controller.duration > 0 ? controller.duration : 1,
              onChanged: (v) => controller.seek(v),
            ),
          ),
          Row(
            children: [
              Text(
                _format(controller.position),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const Spacer(),
              if (onPreviousEpisode != null)
                IconButton(
                  icon: const Icon(Icons.skip_previous_rounded,
                      color: Colors.white),
                  onPressed: onPreviousEpisode,
                ),
              IconButton(
                icon: Icon(
                  controller.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () => controller.togglePlay(),
              ),
              if (onNextEpisode != null)
                IconButton(
                  icon: const Icon(Icons.skip_next_rounded,
                      color: Colors.white),
                  onPressed: onNextEpisode,
                ),
              const Spacer(),
              Text(
                _format(controller.duration),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 16),
              _buildSpeedButton(),
              IconButton(
                icon: const Icon(Icons.fullscreen_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpeedButton() {
    final speeds = [1.0, 1.25, 1.5, 2.0];
    return PopupMenuButton<double>(
      icon: Text(
        '${controller.speed}x',
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
      onSelected: (speed) => controller.setSpeed(speed),
      itemBuilder: (_) => speeds
          .map((s) => PopupMenuItem(
                value: s,
                child: Text('${s}x'),
              ))
          .toList(),
    );
  }

  String _format(double seconds) {
    if (seconds < 0) return '00:00';
    final d = Duration(seconds: seconds.round());
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
