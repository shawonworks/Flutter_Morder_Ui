import 'package:flutter/cupertino.dart';

import '../music_home_screen.dart';

class RecentlyPlayedSection extends StatelessWidget {
  const RecentlyPlayedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MusicSectionHeader(title: 'Recently Played', action: 'History'),
        const SizedBox(height: 14),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          itemCount: tracks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => RecentTrackRow(
            track: tracks[i],
            index: i + 1,
          ),
        ),
      ],
    );
  }
}