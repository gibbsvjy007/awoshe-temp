import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';
part 'video_player_store.g.dart';

class VideoPlayerStore = _VideoPlayerStore with _$VideoPlayerStore;

enum EpisodeStatus {DOWNLOADING, DOWNLOADING_DONE, INITIALIZING, CANCELED, ERROR, BUFFERING, READY}

abstract class _VideoPlayerStore with Store {

  _VideoPlayerStore();

  @observable
  EpisodeStatus episodeLoadingStatus;

  VideoPlayerController controller;

  @observable
  bool isPlaying = false;


  @observable
  Duration currentPosition = Duration(milliseconds: 0);

  void cancelEpisodeLoading() =>
      setEpisodeLoadingStatus(EpisodeStatus.CANCELED);

  @action
  setEpisodeLoadingStatus(EpisodeStatus status){
    print('Inside the action $status');
    episodeLoadingStatus = status;
  }

  @action void _setPlayingStatus(bool status) =>
      isPlaying = status;

  @action void _setCurrentPosition(Duration duration) => currentPosition = duration;

  void playOrPause() {
    if (controller == null)
      return;

    controller.value.isPlaying ?
    controller.pause() :
    controller.play();

    _setPlayingStatus(controller.value.isPlaying);
  }

  void loadVideo(String videoUrl) async {

    setEpisodeLoadingStatus(EpisodeStatus.INITIALIZING);

    try {
      if (controller != null){
        _prepareControllerToAnotherEpisode();
      }

      print('Loading episode $videoUrl');

      controller = (videoUrl.startsWith('https://')) ? VideoPlayerController.network(videoUrl) :
        VideoPlayerController.file(File(videoUrl));

      controller.initialize().then(
              (_){
            controller.addListener( _controllerListener );
            setEpisodeLoadingStatus(EpisodeStatus.READY);
            //playOrPause();

          }
      ).catchError( (_) => setEpisodeLoadingStatus(EpisodeStatus.ERROR) );

    }
    catch (ex){
      setEpisodeLoadingStatus(EpisodeStatus.ERROR);
    }
  }

  void _controllerListener(){
    _setCurrentPosition( controller.value.position );

    // if is the end of the reproduction
    if (controller.value.position.inMilliseconds >= controller.value.duration.inMilliseconds)
      _restartController();

  }

  void _restartController() async {
    final data = Duration(seconds: 0);

    controller.seekTo(  data ).then( (_) => controller.pause() );
    _setCurrentPosition(data);
    _setPlayingStatus(false);
  }

  void _prepareControllerToAnotherEpisode() {
    if (controller.value.isPlaying)
      controller.pause();

    controller.removeListener( _controllerListener );
  }

  void dispose() {
    controller?.removeListener( _controllerListener );

    controller?.dispose();

  }

  void seekTo(int seconds) => controller.seekTo(
      Duration(seconds: (seconds < 0) ? 0 : seconds)
  );
}