import 'package:mobx/mobx.dart';
import '../../data/models/video_detail.dart';
import '../../data/models/episode.dart';
import '../../data/models/playback_source.dart';
import '../../data/models/history_item.dart';
import '../../data/sources/source_registry.dart';
import '../../data/services/history_service.dart';
import '../../shared/utils/url_resolver.dart';
import 'player_controller.dart';

part 'player_page_store.g.dart';

class PlayerPageStore = _PlayerPageStore with _$PlayerPageStore;

abstract class _PlayerPageStore with Store {
  final SourceRegistry _registry;
  final HistoryService _historyService;
  final UrlResolver _urlResolver;
  final PlayerController playerController;

  _PlayerPageStore(
    this._registry,
    this._historyService,
    this._urlResolver,
    this.playerController,
  );

  @observable
  VideoDetail? detail;

  @observable
  int currentEpisodeIndex = 0;

  @observable
  int currentSourceIndex = 0;

  @observable
  String? sourceName;

  @observable
  String? videoId;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool showControls = true;

  @computed
  Episode? get currentEpisode {
    if (detail == null || detail!.episodes.isEmpty) return null;
    if (currentEpisodeIndex >= detail!.episodes.length) return null;
    return detail!.episodes[currentEpisodeIndex];
  }

  @action
  Future<void> loadAndPlay({
    required String sourceName,
    required String videoId,
    int episodeIndex = 0,
    int sourceIndex = 0,
    double resumeFrom = 0.0,
    String? localPath,
  }) async {
    this.sourceName = sourceName;
    this.videoId = videoId;
    this.currentEpisodeIndex = episodeIndex;
    this.currentSourceIndex = sourceIndex;
    isLoading = true;
    error = null;

    try {
      // Local file playback — skip detail loading
      if (localPath != null && sourceName == 'local') {
        await playerController.play(localPath);
        if (resumeFrom > 0) {
          await playerController.seek(resumeFrom);
        }
        isLoading = false;
        return;
      }

      detail = await _registry.getDetail(sourceName, videoId);
      if (detail!.episodes.isNotEmpty) {
        await _playEpisode(currentEpisodeIndex, resumeFrom: resumeFrom);
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> _playEpisode(int index, {double resumeFrom = 0.0}) async {
    if (detail == null || index >= detail!.episodes.length) return;

    currentEpisodeIndex = index;
    final episode = detail!.episodes[index];

    // Resolve the URL
    final resolvedUrl = await _urlResolver.resolve(episode.url);

    // Play
    await playerController.play(resolvedUrl);

    // Seek to resume position if provided
    if (resumeFrom > 0) {
      await playerController.seek(resumeFrom);
    }
  }

  @action
  Future<void> playEpisode(int index) async {
    await _playEpisode(index);
  }

  @action
  Future<void> playNextEpisode() async {
    if (detail == null) return;
    if (currentEpisodeIndex < detail!.episodes.length - 1) {
      await playEpisode(currentEpisodeIndex + 1);
    }
  }

  @action
  Future<void> playPreviousEpisode() async {
    if (currentEpisodeIndex > 0) {
      await playEpisode(currentEpisodeIndex - 1);
    }
  }

  @action
  void toggleControls() {
    showControls = !showControls;
  }

  @action
  Future<void> saveProgress() async {
    if (detail == null || sourceName == null) return;

    await _historyService.add(
      HistoryItem(
        videoId: detail!.videoId,
        title: detail!.title,
        imageUrl: detail!.imageUrl,
        sourceName: sourceName,
        episodeIndex: currentEpisodeIndex,
        episodeName: currentEpisode?.name ?? '',
        position: playerController.position,
        duration: playerController.duration,
        watchedAt: DateTime.now(),
      ),
    );
  }

}
