import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/video_cubit.dart';
import '../../../bloc/video_state.dart';
import 'build_video.dart';

class Video extends StatelessWidget {

  const Video._(
    this.url, {
    Key? key,
    required this.aspectRatio,
  }) : super(key: key);

  static Widget blocProvider(
    String url, {
    required double aspectRatio,
    bool autoPlay = true,
    bool? controlsVisible,
  }) {
    return BlocProvider(
      create: (_) {
        return VideoCubit(
          url,
          autoPlay: autoPlay,
          controlsVisible: controlsVisible ?? !autoPlay,
        );
      },
      child: Video._(
        url,
        aspectRatio: aspectRatio,
      ),
    );
  }

  final String url;
  final double aspectRatio;

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (_, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: AspectRatio(
            key: ValueKey(state.loaded),
            aspectRatio: aspectRatio,
            child: state.notLoaded
                ? const Center(child: CircularProgressIndicator())
                : BuildVideo(state: state, timestamps: [],),
          ),
        );
      },
    );
  }
}
