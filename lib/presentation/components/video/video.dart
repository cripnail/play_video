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
    required this.iconSize,
  }) : super(key: key);

  final String url;
  final double aspectRatio;
  final double iconSize;

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
                : BuildVideo(
                    state: state,
                    timestamps: const [],
                    iconSize: iconSize,
                  ),
          ),
        );
      },
    );
  }

  static blocProvider(String s,
      {required double aspectRatio, required bool autoPlay}) {}
}

class BlocProvider extends StatelessWidget {
  const BlocProvider({
    super.key,
    required this.iconSize,
    required this.url,
    required this.aspectRatio,
    required this.autoPlay,
    required this.controlsVisible,
    required Video child,
    required VideoCubit Function(dynamic _) create,
  });

  final double iconSize;
  final String url;
  final double aspectRatio;
  final bool autoPlay;
  final bool? controlsVisible;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return VideoCubit(
          url,
          autoPlay: autoPlay,
          controlsVisible: controlsVisible ?? !autoPlay,
        );
      },
      iconSize: iconSize,
      url: '',
      aspectRatio: aspectRatio,
      autoPlay: autoPlay,
      controlsVisible: controlsVisible,
      child: Video._(
        url,
        aspectRatio: aspectRatio,
        iconSize: iconSize,
      ),
    );
  }
}
