import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/video_detail.dart';
import '../../data/models/favorite_item.dart';
import '../../data/sources/source_registry.dart';
import '../../data/services/favorite_service.dart';
import '../../data/services/download_service.dart';

part 'detail_store.g.dart';

class DetailStore = _DetailStore with _$DetailStore;

abstract class _DetailStore with Store {
  final SourceRegistry _registry;
  final FavoriteService _favoriteService;
  final DownloadService _downloadService;

  _DetailStore(this._registry, this._favoriteService, this._downloadService);

  @observable
  VideoDetail? detail;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  bool isFavorite = false;

  @action
  Future<void> loadDetail(String sourceName, String videoId) async {
    isLoading = true;
    error = null;

    try {
      detail = await _registry.getDetail(sourceName, videoId);
      isFavorite = await _favoriteService.isFavorite(videoId, sourceName);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleFavorite() async {
    if (detail == null) return;

    if (isFavorite) {
      await _favoriteService.remove(detail!.videoId, detail!.sourceName ?? '');
      isFavorite = false;
    } else {
      await _favoriteService.add(FavoriteItem(
        videoId: detail!.videoId,
        title: detail!.title,
        imageUrl: detail!.imageUrl,
        sourceName: detail!.sourceName,
        typeName: detail!.typeName,
        remarks: detail!.remarks,
        addedAt: DateTime.now(),
      ));
      isFavorite = true;
    }
  }

  @action
  Future<void> downloadEpisodes(List<int> episodeIndices) async {
    if (detail == null) return;

    final saveDir = 'F:/Projects/DarkLightDownloads/${detail!.videoId}';

    for (final index in episodeIndices) {
      if (index >= detail!.episodes.length) continue;
      final episode = detail!.episodes[index];
      final task = await _downloadService.addTask(
        title: detail!.title,
        url: episode.url,
        savePath: '$saveDir/${episode.name}.mp4',
        sourceName: detail!.sourceName,
        episodeName: episode.name,
      );
      await _downloadService.startDownload(task.id);
    }
  }
}
