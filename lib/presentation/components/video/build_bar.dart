import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../bloc/video_cubit.dart';
import 'controls/current_video_position.dart';
import 'controls/custom_control_widget.dart';
import 'controls/progress_indicator_control.dart';

class BuildBar extends StatelessWidget {
  const BuildBar({
    super.key,
    required this.iconSize,
    required this.controller,
    required this.context,
    required this.cubit,
    required this.timestamps,
  });

  final double iconSize;
  final VideoPlayerController controller;
  final BuildContext context;
  final VideoCubit cubit;
  final List<Duration> timestamps;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 4.0,
          ),
          child: Column(
            children: [
              CustomControlsWidget(
                controller: controller,
                timestamps: timestamps,
              ),
            ],
          ),
        ),
      ),
      ProgressIndicatorControl(controller: controller),
      CurrentVideoPosition(videoPlayerController: controller),
    ]);
  }
}
