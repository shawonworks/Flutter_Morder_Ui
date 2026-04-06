import 'package:flutter/cupertino.dart';

import '../music_home_screen.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MusicSectionHeader(title: '🔥 Trending Now', action: 'See all'),
        const SizedBox(height: 14),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemCount: tracks.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, i) => TrendingCard(
              track: tracks[i],
              rank: i + 1,
            ),
          ),
        ),
      ],
    );
  }
}