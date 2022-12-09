import 'package:flutter/material.dart';

import '../components/video/video.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home page',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Video.blocProvider(
              // Normally you'll get both the url and the aspect ratio from your video meta data
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
              aspectRatio: 1.77,
              autoPlay: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Watch the bee here!',
            ),
          ),
        ],
      ),
    );
  }
}
