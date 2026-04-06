import 'package:flutter/cupertino.dart';

import '../music_home_screen.dart';

class FeaturedPlayerCard extends StatelessWidget {
  final Track track;
  final bool isPlaying;
  final AnimationController vinylController;
  final VoidCallback onTogglePlay;

  const FeaturedPlayerCard({
    super.key,
    required this.track,
    required this.isPlaying,
    required this.vinylController,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            track.colors[0].withAlpha(64),
            track.colors[1].withAlpha(26),
            kCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: track.colors[0].withAlpha(77)),
        boxShadow: [
          BoxShadow(
            color: track.colors[0].withAlpha(51),
            blurRadius: 32,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Vinyl record
              VinylRecord(
                emoji: track.emoji,
                colors: track.colors,
                controller: vinylController,
              ),
              const SizedBox(width: 18),
              // Track info
              Expanded(
                child: TrackInfo(
                  track: track,
                  accentColor: track.colors[0],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          // Progress bar
          const PlayerProgressBar(),
          const SizedBox(height: 18),
          // Controls
          PlayerControls(
            isPlaying: isPlaying,
            accentColor: track.colors[0],
            onTogglePlay: onTogglePlay,
          ),
        ],
      ),
    );
  }
}