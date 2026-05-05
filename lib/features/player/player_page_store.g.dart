// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerPageStore on _PlayerPageStore, Store {
  Computed<Episode?>? _$currentEpisodeComputed;

  @override
  Episode? get currentEpisode =>
      (_$currentEpisodeComputed ??= Computed<Episode?>(
        () => super.currentEpisode,
        name: '_PlayerPageStore.currentEpisode',
      )).value;

  late final _$detailAtom = Atom(
    name: '_PlayerPageStore.detail',
    context: context,
  );

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

  late final _$currentEpisodeIndexAtom = Atom(
    name: '_PlayerPageStore.currentEpisodeIndex',
    context: context,
  );

  @override
  int get currentEpisodeIndex {
    _$currentEpisodeIndexAtom.reportRead();
    return super.currentEpisodeIndex;
  }

  @override
  set currentEpisodeIndex(int value) {
    _$currentEpisodeIndexAtom.reportWrite(value, super.currentEpisodeIndex, () {
      super.currentEpisodeIndex = value;
    });
  }

  late final _$currentSourceIndexAtom = Atom(
    name: '_PlayerPageStore.currentSourceIndex',
    context: context,
  );

  @override
  int get currentSourceIndex {
    _$currentSourceIndexAtom.reportRead();
    return super.currentSourceIndex;
  }

  @override
  set currentSourceIndex(int value) {
    _$currentSourceIndexAtom.reportWrite(value, super.currentSourceIndex, () {
      super.currentSourceIndex = value;
    });
  }

  late final _$sourceNameAtom = Atom(
    name: '_PlayerPageStore.sourceName',
    context: context,
  );

  @override
  String? get sourceName {
    _$sourceNameAtom.reportRead();
    return super.sourceName;
  }

  @override
  set sourceName(String? value) {
    _$sourceNameAtom.reportWrite(value, super.sourceName, () {
      super.sourceName = value;
    });
  }

  late final _$videoIdAtom = Atom(
    name: '_PlayerPageStore.videoId',
    context: context,
  );

  @override
  String? get videoId {
    _$videoIdAtom.reportRead();
    return super.videoId;
  }

  @override
  set videoId(String? value) {
    _$videoIdAtom.reportWrite(value, super.videoId, () {
      super.videoId = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PlayerPageStore.isLoading',
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

  late final _$errorAtom = Atom(
    name: '_PlayerPageStore.error',
    context: context,
  );

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

  late final _$showControlsAtom = Atom(
    name: '_PlayerPageStore.showControls',
    context: context,
  );

  @override
  bool get showControls {
    _$showControlsAtom.reportRead();
    return super.showControls;
  }

  @override
  set showControls(bool value) {
    _$showControlsAtom.reportWrite(value, super.showControls, () {
      super.showControls = value;
    });
  }

  late final _$loadAndPlayAsyncAction = AsyncAction(
    '_PlayerPageStore.loadAndPlay',
    context: context,
  );

  @override
  Future<void> loadAndPlay({
    required String sourceName,
    required String videoId,
    int episodeIndex = 0,
    int sourceIndex = 0,
    double resumeFrom = 0.0,
    String? localPath,
  }) {
    return _$loadAndPlayAsyncAction.run(
      () => super.loadAndPlay(
        sourceName: sourceName,
        videoId: videoId,
        episodeIndex: episodeIndex,
        sourceIndex: sourceIndex,
        resumeFrom: resumeFrom,
        localPath: localPath,
      ),
    );
  }

  late final _$_playEpisodeAsyncAction = AsyncAction(
    '_PlayerPageStore._playEpisode',
    context: context,
  );

  @override
  Future<void> _playEpisode(int index, {double resumeFrom = 0.0}) {
    return _$_playEpisodeAsyncAction.run(
      () => super._playEpisode(index, resumeFrom: resumeFrom),
    );
  }

  late final _$playEpisodeAsyncAction = AsyncAction(
    '_PlayerPageStore.playEpisode',
    context: context,
  );

  @override
  Future<void> playEpisode(int index) {
    return _$playEpisodeAsyncAction.run(() => super.playEpisode(index));
  }

  late final _$playNextEpisodeAsyncAction = AsyncAction(
    '_PlayerPageStore.playNextEpisode',
    context: context,
  );

  @override
  Future<void> playNextEpisode() {
    return _$playNextEpisodeAsyncAction.run(() => super.playNextEpisode());
  }

  late final _$playPreviousEpisodeAsyncAction = AsyncAction(
    '_PlayerPageStore.playPreviousEpisode',
    context: context,
  );

  @override
  Future<void> playPreviousEpisode() {
    return _$playPreviousEpisodeAsyncAction.run(
      () => super.playPreviousEpisode(),
    );
  }

  late final _$saveProgressAsyncAction = AsyncAction(
    '_PlayerPageStore.saveProgress',
    context: context,
  );

  @override
  Future<void> saveProgress() {
    return _$saveProgressAsyncAction.run(() => super.saveProgress());
  }

  late final _$_PlayerPageStoreActionController = ActionController(
    name: '_PlayerPageStore',
    context: context,
  );

  @override
  void toggleControls() {
    final _$actionInfo = _$_PlayerPageStoreActionController.startAction(
      name: '_PlayerPageStore.toggleControls',
    );
    try {
      return super.toggleControls();
    } finally {
      _$_PlayerPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
detail: ${detail},
currentEpisodeIndex: ${currentEpisodeIndex},
currentSourceIndex: ${currentSourceIndex},
sourceName: ${sourceName},
videoId: ${videoId},
isLoading: ${isLoading},
error: ${error},
showControls: ${showControls},
currentEpisode: ${currentEpisode}
    ''';
  }
}
