import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// This class is a mini video player widget used in video upload/update step.
class AwosheStepVideoPlayer extends StatefulWidget {
  final double width, height;
  final String videoUrl;

  final VideoPlayerController controller;

  const AwosheStepVideoPlayer(
      {Key key, @required
      this.videoUrl,
      this.controller, this.width, this.height})
      : super(key: key);

  @override
  _AwosheStepVideoPlayerState createState() => _AwosheStepVideoPlayerState();
}

class _AwosheStepVideoPlayerState extends State<AwosheStepVideoPlayer> {

  IconData currentIcon;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);

    currentIcon =
      (!widget.controller.value.isPlaying) ?
        Icons.play_arrow : Icons.pause;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,


      child: AspectRatio(
        aspectRatio: widget.controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            VideoPlayer(
              widget.controller,
            ),

            Align(
              child: IconButton(
                color: Colors.white.withOpacity(.7),
                iconSize: 70,
                icon: Icon(currentIcon),
                
                onPressed: () async {
                  if (widget.controller.value.isPlaying) {
                    print('Pausing');
                    await widget.controller.pause();
                    currentIcon = Icons.play_arrow;
                    setState(() {});
                    return;
                  }
                  else if (widget.controller.value.position ==
                      widget.controller.value.duration) {
                        
                    await widget.controller.seekTo(Duration(seconds: 0));
                  }
                  await widget.controller.play();
                  currentIcon = Icons.pause;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listener() {
    if (widget.controller.value.position == widget.controller.value.duration)
      setState(() {
        currentIcon = Icons.refresh;
      });
  }

  @override
  void dispose() {
    widget.controller?.removeListener( _listener );
    super.dispose();
  }
}
