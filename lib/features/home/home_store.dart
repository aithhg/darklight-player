import 'package:mobx/mobx.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/search_result.dart';
import '../../data/sources/source_registry.dart';

part 'home_store.g.dart';

const _source = '量子资源';

/// Hardcoded recommendations — pre-verified IDs from 量子资源.
final _hardcodedRecommendations = [
  const SearchResult(videoId: '37823', title: '士兵突击', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20220401-1/cdd201c456b2205ebab319073814a88d.jpg'),
  const SearchResult(videoId: '3176', title: '爱情公寓第二季', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20220401-1/cdd201c456b2205ebab319073814a88d.jpg'),
  const SearchResult(videoId: '3177', title: '爱情公寓第三季', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20220401-1/3a6222f0c7cf5a1bc427e3778aff1647.jpg'),
  const SearchResult(videoId: '3178', title: '爱情公寓第四季', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20220401-1/782c79e767d2f9c905884f0209e2c7b6.jpg'),
  const SearchResult(videoId: '65737', title: '大明王朝1566', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20230703-1/fe9fea52f6cb8afa15507357ee59427e.jpg'),
  const SearchResult(videoId: '53747', title: '地球脉动第二季', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20230313-1/35faa0e5924f74324b7497341b664d7a.jpg'),
  const SearchResult(videoId: '79360', title: '舌尖上的中国第一季', sourceName: _source, imageUrl: 'https://img.lzzyimg.com/upload/vod/20231226-1/149dd67a96923864b953fabf0ca987a4.jpg'),
  const SearchResult(videoId: '79361', title: '舌尖上的中国第二季', sourceName: _source, imageUrl: 'https://img.lzzyimg.com/upload/vod/20231226-1/7e152af8a414097bda545c9f9dac3cfa.jpg'),
  const SearchResult(videoId: '131030', title: '放开那个女巫', sourceName: _source, imageUrl: 'https://viptulz.com/upload/vod/20260315-1/2e8b9e3a35655c7a694fd083a8cbaaf1.webp'),
  const SearchResult(videoId: '128369', title: '飞驰人生3', sourceName: _source, imageUrl: 'https://viptulz.com/upload/vod/20260219-1/3e93d690a74b61a8857ce9db527ddbc9.webp'),
  const SearchResult(videoId: '38956', title: '机器人瓦力', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20221110-1/035894d13305b011644bf6c88305cb53.jpg'),
  const SearchResult(videoId: '39222', title: '爱在黎明破晓前', sourceName: _source, imageUrl: 'https://pic.lzzypic.com/upload/vod/20221112-1/832126f6299a9fdba55652f95b86fe86.jpg'),
  const SearchResult(videoId: '122806', title: '一人之下第六季', sourceName: _source, imageUrl: 'https://viptulz.com/upload/vod/20260102-1/82d5447d8d1c54e09b277b28945a0d03.jpg'),
];

const _genreCategories = {
  '电影': '电影',
  '剧集': '剧集',
  '动漫': '动漫',
  '综艺': '综艺',
  '纪录片': '纪录片',
};

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final SourceRegistry _registry;

  _HomeStore(this._registry);

  @observable
  ObservableList<SearchResult> recommendations = ObservableList.of([]);

  @observable
  ObservableMap<String, List<SearchResult>> genreSections =
      ObservableMap.of({});

  @observable
  ObservableMap<String, List<SearchResult>> feedSections =
      ObservableMap.of({});

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> loadFeeds() async {
    isLoading = true;
    error = null;

    // Recommendations are hardcoded — load instantly
    recommendations.clear();
    recommendations.addAll(_hardcodedRecommendations);

    try {
      await Future.wait([
        _loadGenreSections(),
        _loadSourceFeeds(),
      ]);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> _loadSourceFeeds() async {
    final feeds = await _registry.getAllHomeFeeds();
    feeds.remove('森林资源');
    // 过滤恐怖片
    for (final key in feeds.keys.toList()) {
      feeds[key] = feeds[key]!.where((item) =>
        !(item.typeName?.contains('恐怖') ?? false)
      ).toList();
    }
    feedSections.clear();
    feedSections.addAll(feeds);
  }

  Future<void> _loadGenreSections() async {
    final map = <String, List<SearchResult>>{};
    for (final entry in _genreCategories.entries) {
      try {
        final results = await _registry.searchAll(entry.value);
        map[entry.key] = results
            .where((item) => !(item.typeName?.contains('恐怖') ?? false))
            .take(20)
            .toList();
      } catch (_) {
        map[entry.key] = [];
      }
    }
    genreSections.clear();
    genreSections.addAll(map);
  }

  @action
  Future<void> refresh() async {
    await loadFeeds();
  }
}
