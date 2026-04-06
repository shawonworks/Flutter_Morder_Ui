import 'package:flutter/cupertino.dart';

import '../music_home_screen.dart';

class ArtistSection extends StatelessWidget {
  const ArtistSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MusicSectionHeader(title: 'Top Artists', action: 'See all'),
        const SizedBox(height: 14),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemCount: artists.length,
            separatorBuilder: (_, __) => const SizedBox(width: 18),
            itemBuilder: (_, i) => ArtistChip(artist: artists[i]),
          ),
        ),
      ],
    );
  }
}