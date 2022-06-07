import 'package:Awoshe/logic/stores/video/video_player_store.dart';
import 'package:Awoshe/theme/theme.dart';
import 'package:Awoshe/widgets/loading.dart';
import 'package:Awoshe/widgets/no_data_available.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:video_player/video_player.dart';




class AwosheVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const AwosheVideoPlayer({Key key, @required this.videoUrl}) : super(key: key);
  @override
  _AwosheVideoPlayerState createState() => _AwosheVideoPlayerState();
}

//enum _MenuOption { NEXT, PREVIOUS, EXIT }

class _AwosheVideoPlayerState extends State<AwosheVideoPlayer>
    with TickerProviderStateMixin {

  AnimationController animationController;

  Animation downTopTransition;

  Animation opacityAnimation;

  VideoPlayerStore videoPlayerStore;

//  static const _DEFAULT_ASPECT_RATIO = 3 / 2;

  @override
  void initState() {


    super.initState();

    videoPlayerStore = VideoPlayerStore();
    videoPlayerStore.loadVideo(widget.videoUrl);

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );


    downTopTransition = Tween<Offset>(begin: Offset(.0, 50), end: Offset.zero)
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastLinearToSlowEaseIn));

    opacityAnimation = Tween<double>(begin: .0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeIn));
  }

  @override
  void dispose() {
    animationController?.dispose();
    videoPlayerStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
          child: Observer(
            builder: (_) {
              Widget currentWidget;

              switch (videoPlayerStore.episodeLoadingStatus) {
                case EpisodeStatus.INITIALIZING:
                case EpisodeStatus.BUFFERING:
                case EpisodeStatus.DOWNLOADING_DONE:
                case EpisodeStatus.DOWNLOADING:
                  currentWidget = buildLoaderWidget();
                  break;

                case EpisodeStatus.CANCELED:
                  currentWidget = Container();
                  break;

                case EpisodeStatus.ERROR:
                  currentWidget = Center(
                    child: NoDataAvailable(
                      message: 'Video unavailable',
                    ),
                  );

                  break;

                case EpisodeStatus.READY:
                  currentWidget = buildPlayerWidget(size);
                  animationController.forward(from: .0);
                  break;
              }
              return currentWidget;
            },
          ),

    );
  }

  Widget buildPlayerWidget(final Size size) => GestureDetector(
    onDoubleTap: (){
      print('Full screen or non fullscreen method?');
    },
    onTap: () {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    },
    child: Container(
      width: size.width,
      height: size.height,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio:  videoPlayerStore.controller.value.aspectRatio, //_DEFAULT_ASPECT_RATIO,
              child: VideoPlayer(videoPlayerStore.controller),
            ),
          ),

          AnimatedBuilder(
              animation: animationController,
              builder: (_, __) => FadeTransition(
                opacity: opacityAnimation,
                child: buildCenterControllersWidget(
                    size, animationController.isCompleted),
              )),
          AnimatedBuilder(
            animation: animationController,
            builder: (_, __) => SlideTransition(
              position: downTopTransition,
              child: buildBottomBarWidget(size),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildLoaderWidget() => Center(
    child: AwosheLoadingV2(),
  );

  Widget buildCenterControllersWidget(final Size size, bool available) => Align(
    alignment: Alignment.center,
    child: Container(
      width: size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            disabledColor: Colors.white,
            color: Colors.white,
            iconSize: 65.0,
            icon: Icon(
              Icons.replay_10,
            ),
            onPressed: available
                ? () => videoPlayerStore
                .seekTo(videoPlayerStore.currentPosition.inSeconds - 10)
                : null,
          ),
          IconButton(
            disabledColor: Colors.white,
            color: Colors.white,
            iconSize: 100,
            icon: Observer(
              builder: (_) {
                var icon = videoPlayerStore.isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline;
                return Icon(
                  icon,
                );
              },
            ),
            onPressed:
            available ? () => videoPlayerStore.playOrPause() : null,
          ),
          IconButton(
            disabledColor: Colors.white,
            iconSize: 65.0,
            color: Colors.white,
            icon: Icon(
              Icons.forward_10,
            ),
            onPressed: available
                ? () => videoPlayerStore
                .seekTo(videoPlayerStore.currentPosition.inSeconds + 10)
                : null,
          ),
        ],
      ),
    ),
  );

  Widget buildBottomBarWidget(final Size size) => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: size.width,
      height: 80,
      color: Colors.transparent,
      child: Observer(
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SliderTheme(
                data: SliderThemeData(
                  thumbColor: primaryColor,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 7,
                  ),
                ),
                child: Container(
                  height: 30,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Slider(
                    activeColor: primaryColor,
                    value: videoPlayerStore.currentPosition.inSeconds
                        .toDouble(),
                    min: .0,
                    max: videoPlayerStore
                        .controller.value.duration.inSeconds
                        .toDouble(),
                    onChanged: (value) =>
                        videoPlayerStore.seekTo(value.toInt()),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 24.0, bottom: 8.0),
                  child: Text(
                    "${_printDuration(videoPlayerStore.currentPosition)}" +
                        " / ${_printDuration(videoPlayerStore.controller.value.duration)}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          );
        },
      ),
    ),
  );

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes);
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
