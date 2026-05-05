import 'package:mobx/mobx.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../../data/models/playback_source.dart';

part 'player_controller.g.dart';

class PlayerController = _PlayerController with _$PlayerController;

abstract class _PlayerController with Store {
  late final Player _player;
  late final VideoController videoController;

  _PlayerController() {
    _player = Player();
    videoController = VideoController(_player);
  }

  @observable
  bool isPlaying = false;

  @observable
  double position = 0.0;

  @observable
  double duration = 0.0;

  @observable
  double volume = 100.0;

  @observable
  double speed = 1.0;

  @observable
  bool isBuffering = false;

  @observable
  String? error;

  @observable
  bool isInitialized = false;

  @action
  Future<void> initialize() async {
    if (isInitialized) return;

    // Listen to player streams
    _player.stream.playing.listen((playing) => isPlaying = playing);
    _player.stream.position.listen((pos) => position = pos.inSeconds.toDouble());
    _player.stream.duration.listen((dur) => duration = dur.inSeconds.toDouble());
    _player.stream.volume.listen((vol) => volume = vol);
    _player.stream.rate.listen((rate) => speed = rate);
    _player.stream.buffering.listen((buf) => isBuffering = buf);
    _player.stream.error.listen((err) => error = err);

    isInitialized = true;
  }

  @action
  Future<void> play(String url) async {
    try {
      error = null;
      await _player.open(Media(url));
    } catch (e) {
      error = e.toString();
    }
  }

  @action
  Future<void> playSource(PlaybackSource source) async {
    if (source.urls.isEmpty) {
      error = 'No playback URLs available';
      return;
    }
    await play(source.urls.first);
  }

  @action
  Future<void> togglePlay() async {
    await _player.playOrPause();
  }

  @action
  Future<void> pause() async {
    await _player.pause();
  }

  @action
  Future<void> resume() async {
    await _player.play();
  }

  @action
  Future<void> seek(double seconds) async {
    await _player.seek(Duration(seconds: seconds.round()));
  }

  @action
  Future<void> setVolume(double vol) async {
    await _player.setVolume(vol);
  }

  @action
  Future<void> setSpeed(double rate) async {
    await _player.setRate(rate);
  }

  @action
  Future<void> skipForward({int seconds = 10}) async {
    final newPos = position + seconds;
    if (newPos < duration) {
      await seek(newPos);
    }
  }

  @action
  Future<void> skipBackward({int seconds = 10}) async {
    final newPos = (position - seconds).clamp(0.0, duration);
    await seek(newPos);
  }

  void dispose() {
    _player.dispose();
  }
}
