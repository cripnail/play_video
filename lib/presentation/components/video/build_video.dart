import 'package:flutter/material.dart';
import 'package:media_player/presentation/components/video/video_controls.dart';
import 'package:video_player/video_player.dart';

import '../../../bloc/video_state.dart';

class BuildVideo extends StatelessWidget {
  const BuildVideo({
    super.key,
    required this.state,
    required this.timestamps,
  });

  final VideoState state;
  final List<Duration> timestamps;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        VideoPlayer(
          state.controller,
        ),
        VideoControls(
          state.controller,
          timestamps: timestamps,
        ),
      ],
    );
  }
}
