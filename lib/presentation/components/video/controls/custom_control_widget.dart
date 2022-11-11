import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'build_button.dart';

class CustomControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const CustomControlsWidget({
    required this.controller,
    Key? key, required List<Duration> timestamps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 12),
      BuildButton(
          onPressed: rewind10Seconds, child: const Icon(Icons.replay_10)),
      const SizedBox(width: 12),
      BuildButton(
          onPressed: forward10Seconds, child: const Icon(Icons.forward_10)),
      const SizedBox(width: 12),
    ],
  );

  Future forward10Seconds() async => goToPosition(
          (currentPosition) => currentPosition + const Duration(seconds: 10));

  Future rewind10Seconds() async => goToPosition(
          (currentPosition) => currentPosition - const Duration(seconds: 10));

  Future goToPosition(
      Duration Function(Duration currentPosition) builder,
      ) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition!);

    await controller.seekTo(newPosition);
  }
}
