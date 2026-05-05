// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailStore on _DetailStore, Store {
  late final _$detailAtom = Atom(name: '_DetailStore.detail', context: context);

  @override
  VideoDetail? get detail {
    _$detailAtom.reportRead();
    return super.detail;
  }

  @override
  set detail(VideoDetail? value) {
    _$detailAtom.reportWrite(value, super.detail, () {
      super.detail = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_DetailStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: '_DetailStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isFavoriteAtom = Atom(
    name: '_DetailStore.isFavorite',
    context: context,
  );

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  late final _$loadDetailAsyncAction = AsyncAction(
    '_DetailStore.loadDetail',
    context: context,
  );

  @override
  Future<void> loadDetail(String sourceName, String videoId) {
    return _$loadDetailAsyncAction.run(
      () => super.loadDetail(sourceName, videoId),
    );
  }

  late final _$toggleFavoriteAsyncAction = AsyncAction(
    '_DetailStore.toggleFavorite',
    context: context,
  );

  @override
  Future<void> toggleFavorite() {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite());
  }

  late final _$downloadEpisodesAsyncAction = AsyncAction(
    '_DetailStore.downloadEpisodes',
    context: context,
  );

  @override
  Future<void> downloadEpisodes(List<int> episodeIndices) {
    return _$downloadEpisodesAsyncAction.run(
      () => super.downloadEpisodes(episodeIndices),
    );
  }

  @override
  String toString() {
    return '''
detail: ${detail},
isLoading: ${isLoading},
error: ${error},
isFavorite: ${isFavorite}
    ''';
  }
}
