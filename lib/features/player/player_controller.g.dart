// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlayerController on _PlayerController, Store {
  late final _$isPlayingAtom = Atom(
    name: '_PlayerController.isPlaying',
    context: context,
  );

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  late final _$positionAtom = Atom(
    name: '_PlayerController.position',
    context: context,
  );

  @override
  double get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(double value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$durationAtom = Atom(
    name: '_PlayerController.duration',
    context: context,
  );

  @override
  double get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(double value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$volumeAtom = Atom(
    name: '_PlayerController.volume',
    context: context,
  );

  @override
  double get volume {
    _$volumeAtom.reportRead();
    return super.volume;
  }

  @override
  set volume(double value) {
    _$volumeAtom.reportWrite(value, super.volume, () {
      super.volume = value;
    });
  }

  late final _$speedAtom = Atom(
    name: '_PlayerController.speed',
    context: context,
  );

  @override
  double get speed {
    _$speedAtom.reportRead();
    return super.speed;
  }

  @override
  set speed(double value) {
    _$speedAtom.reportWrite(value, super.speed, () {
      super.speed = value;
    });
  }

  late final _$isBufferingAtom = Atom(
    name: '_PlayerController.isBuffering',
    context: context,
  );

  @override
  bool get isBuffering {
    _$isBufferingAtom.reportRead();
    return super.isBuffering;
  }

  @override
  set isBuffering(bool value) {
    _$isBufferingAtom.reportWrite(value, super.isBuffering, () {
      super.isBuffering = value;
    });
  }

  late final _$errorAtom = Atom(
    name: '_PlayerController.error',
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

  late final _$isInitializedAtom = Atom(
    name: '_PlayerController.isInitialized',
    context: context,
  );

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  late final _$initializeAsyncAction = AsyncAction(
    '_PlayerController.initialize',
    context: context,
  );

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$playAsyncAction = AsyncAction(
    '_PlayerController.play',
    context: context,
  );

  @override
  Future<void> play(String url) {
    return _$playAsyncAction.run(() => super.play(url));
  }

  late final _$playSourceAsyncAction = AsyncAction(
    '_PlayerController.playSource',
    context: context,
  );

  @override
  Future<void> playSource(PlaybackSource source) {
    return _$playSourceAsyncAction.run(() => super.playSource(source));
  }

  late final _$togglePlayAsyncAction = AsyncAction(
    '_PlayerController.togglePlay',
    context: context,
  );

  @override
  Future<void> togglePlay() {
    return _$togglePlayAsyncAction.run(() => super.togglePlay());
  }

  late final _$pauseAsyncAction = AsyncAction(
    '_PlayerController.pause',
    context: context,
  );

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$resumeAsyncAction = AsyncAction(
    '_PlayerController.resume',
    context: context,
  );

  @override
  Future<void> resume() {
    return _$resumeAsyncAction.run(() => super.resume());
  }

  late final _$seekAsyncAction = AsyncAction(
    '_PlayerController.seek',
    context: context,
  );

  @override
  Future<void> seek(double seconds) {
    return _$seekAsyncAction.run(() => super.seek(seconds));
  }

  late final _$setVolumeAsyncAction = AsyncAction(
    '_PlayerController.setVolume',
    context: context,
  );

  @override
  Future<void> setVolume(double vol) {
    return _$setVolumeAsyncAction.run(() => super.setVolume(vol));
  }

  late final _$setSpeedAsyncAction = AsyncAction(
    '_PlayerController.setSpeed',
    context: context,
  );

  @override
  Future<void> setSpeed(double rate) {
    return _$setSpeedAsyncAction.run(() => super.setSpeed(rate));
  }

  late final _$skipForwardAsyncAction = AsyncAction(
    '_PlayerController.skipForward',
    context: context,
  );

  @override
  Future<void> skipForward({int seconds = 10}) {
    return _$skipForwardAsyncAction.run(
      () => super.skipForward(seconds: seconds),
    );
  }

  late final _$skipBackwardAsyncAction = AsyncAction(
    '_PlayerController.skipBackward',
    context: context,
  );

  @override
  Future<void> skipBackward({int seconds = 10}) {
    return _$skipBackwardAsyncAction.run(
      () => super.skipBackward(seconds: seconds),
    );
  }

  @override
  String toString() {
    return '''
isPlaying: ${isPlaying},
position: ${position},
duration: ${duration},
volume: ${volume},
speed: ${speed},
isBuffering: ${isBuffering},
error: ${error},
isInitialized: ${isInitialized}
    ''';
  }
}
