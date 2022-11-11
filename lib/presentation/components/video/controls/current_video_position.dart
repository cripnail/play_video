import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const _currentVideoPositionWidth = 38.0;
const _minTwoDigitValue = 10;

class CurrentVideoPosition extends StatefulWidget {
  const CurrentVideoPosition({
    Key? key,
    required this.videoPlayerController,
  }) : super(key: key);
  final VideoPlayerController videoPlayerController;

  @override
  CurrentVideoPositionState createState() => CurrentVideoPositionState();
}

class CurrentVideoPositionState extends State<CurrentVideoPosition> {
  int currentDurationInSecond = 0;

  @override
  void initState() {
    widget.videoPlayerController.addListener(
      () => setState(() => currentDurationInSecond =
          widget.videoPlayerController.value.position.inSeconds),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: _currentVideoPositionWidth,
        alignment: Alignment.centerRight,
        child: Text(
          _formatCurrentPosition(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
          maxLines: 1,
        ),
      );

  String _formatCurrentPosition() => currentDurationInSecond < _minTwoDigitValue
      ? "0 : 0$currentDurationInSecond"
      : "0 : $currentDurationInSecond";
}
