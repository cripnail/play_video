import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../bloc/video_cubit.dart';
import '../../../bloc/video_state.dart';
import 'build_bar.dart';

class VideoControls extends StatelessWidget {
  const VideoControls(
    this.controller, {
    Key? key,
    this.iconSize = 36,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 4.0,
    ),
    required this.timestamps,
  }) : super(key: key);

  final VideoPlayerController controller;
  final double iconSize;
  final EdgeInsets padding;
  final List<Duration> timestamps;

  static const _heightProgressControl = 90.0;

  double get height => iconSize + _heightProgressControl + padding.vertical;

  double _getOffsetY(
    bool visible,
    bool initialVisibility,
  ) {
    // No animation on initial visibility
    if (initialVisibility) {
      return 0;
    }
    return visible ? 0 : height * -1;
  }

  Offset _getOffset(
    bool visible,
    bool initialVisibility,
  ) {
    return Offset(
      0.0,
      _getOffsetY(
        visible,
        initialVisibility,
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final cubit = BlocProvider.of<VideoCubit>(context);
    return GestureDetector(
      onTap: cubit.toggleControlsVisibility,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: height,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                BlocBuilder<VideoCubit, VideoState>(
                  buildWhen: (previous, current) {
                    return previous.controlsVisible != current.controlsVisible;
                  },
                  builder: (context, state) {
                    return TweenAnimationBuilder<Offset>(
                      duration: const Duration(milliseconds: 150),
                      tween: Tween<Offset>(
                        begin: _getOffset(
                          state.controlsNotVisible,
                          state.visibilityNotChanged,
                        ),
                        end: _getOffset(
                          state.controlsVisible,
                          state.visibilityNotChanged,
                        ),
                      ),
                      builder: (_, value, child) {
                        return Positioned(
                          height: height,
                          left: 0.0,
                          right: 0.0,
                          bottom: value.dy,
                          child: child!,
                        );
                      },
                      child: BuildBar(
                          iconSize: iconSize,
                          controller: controller,
                          context: context,
                          cubit: cubit,
                          timestamps: timestamps),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
