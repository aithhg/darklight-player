import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/service_provider.dart';
import 'player_controller.dart';
import 'player_page_store.dart';
import 'player_controls.dart';
import 'source_panel.dart';

class PlayerView extends StatefulWidget {
  final String sourceName;
  final String videoId;
  final int episodeIndex;
  final int sourceIndex;
  final String title;
  final double resumeFrom;
  final String? localPath;

  const PlayerView({
    super.key,
    required this.sourceName,
    required this.videoId,
    this.episodeIndex = 0,
    this.sourceIndex = 0,
    this.title = '',
    this.resumeFrom = 0.0,
    this.localPath,
  });

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late final PlayerController _playerController;
  PlayerPageStore? _pageStore;
  bool _initialized = false;
  Timer? _hideControlsTimer;
  static const _autoHideDelay = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    _playerController.initialize();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Keyboard listener for Escape key (desktop back navigation)
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
    _startAutoHideTimer();
  }

  void _startAutoHideTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(_autoHideDelay, () {
      _pageStore?.showControls = false;
    });
  }

  void _onUserActivity() {
    _pageStore?.showControls = true;
    _startAutoHideTimer();
  }

  void _onTapVideo() {
    _pageStore!.toggleControls();
    if (_pageStore!.showControls) {
      _startAutoHideTimer();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  /// Handler for keyboard events — Escape key triggers back navigation.
  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
      Navigator.of(context).pop();
      return true;
    }
    return false;
  }

  void _handleBack() {
    _pageStore?.saveProgress();
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final sp = context.read<ServiceProvider>();
      _pageStore = PlayerPageStore(
        sp.sourceRegistry,
        sp.historyService,
        sp.urlResolver,
        _playerController,
      );
      _pageStore!.loadAndPlay(
        sourceName: widget.sourceName,
        videoId: widget.videoId,
        episodeIndex: widget.episodeIndex,
        sourceIndex: widget.sourceIndex,
        resumeFrom: widget.resumeFrom,
        localPath: widget.localPath,
      );
    }
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    _pageStore?.saveProgress();
    _playerController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MouseRegion(
          onHover: (_) => _onUserActivity(),
          onEnter: (_) => _onUserActivity(),
          child: Observer(
            builder: (_) {
              if (_pageStore == null) return const SizedBox.shrink();

              final showControls = _pageStore!.showControls;
              final detail = _pageStore!.detail;

              return Stack(
                children: [
                  // Tap-to-toggle area (behind everything else — only fires on
                  // bare video area, not on controls that sit above it)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => _onTapVideo(),
                      behavior: HitTestBehavior.translucent,
                      child: const SizedBox.expand(),
                    ),
                  ),
                // Video surface
                Center(
                  child: Video(controller: _playerController.videoController),
                ),
                // Loading indicator
                if (_playerController.isBuffering)
                  const Center(
                    child: CircularProgressIndicator(
                        color: AppTheme.accent, strokeWidth: 3),
                  ),
                // Error overlay
                if (_playerController.error != null)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline_rounded,
                            size: 48, color: AppTheme.error),
                        const SizedBox(height: 12),
                        Text(_playerController.error!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _pageStore!.playEpisode(
                              _pageStore!.currentEpisodeIndex),
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  ),
                // Controls overlay (rendered above the tap-to-toggle area,
                // so its buttons always receive taps without competing)
                if (showControls)
                  PlayerControls(
                    controller: _playerController,
                    title: detail?.title ?? widget.title,
                    onBack: () => _handleBack(),
                    onPreviousEpisode: _pageStore!.currentEpisodeIndex > 0
                        ? () => _pageStore!.playPreviousEpisode()
                        : null,
                    onNextEpisode: detail != null &&
                            _pageStore!.currentEpisodeIndex <
                                detail.episodes.length - 1
                        ? () => _pageStore!.playNextEpisode()
                        : null,
                  ),
                // Episode panel (right side)
                if (showControls && detail != null && detail.episodes.length > 1)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SourcePanel(
                      episodes: detail.episodes,
                      currentEpisodeIndex: _pageStore!.currentEpisodeIndex,
                      onEpisodeTap: (index) =>
                          _pageStore!.playEpisode(index),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      ),
    );
  }
}
