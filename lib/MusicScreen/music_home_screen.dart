import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Widget/featured_player_card.dart';
import 'Widget/genre_section.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const SoundWaveApp());
}

// ══════════════════════════════════════════════════════════════
//  COLORS
// ══════════════════════════════════════════════════════════════
const kBg         = Color(0xFF08080F);
const kSurface    = Color(0xFF111120);
const kCard       = Color(0xFF17172A);
const kCardLight  = Color(0xFF1E1E35);
const kNeon       = Color(0xFFB14FFF);   // electric purple
const kNeonPink   = Color(0xFFFF4FBC);
const kNeonBlue   = Color(0xFF4FFFFF);   // cyan
const kGold       = Color(0xFFFFD166);
const kWhite      = Color(0xFFFFFFFF);
const kWhite80    = Color(0xCCFFFFFF);
const kWhite50    = Color(0x80FFFFFF);
const kWhite20    = Color(0x33FFFFFF);
const kWhite10    = Color(0x1AFFFFFF);
const kBorder     = Color(0xFF252540);

// ══════════════════════════════════════════════════════════════
//  DATA MODELS
// ══════════════════════════════════════════════════════════════
class Track {
  final String title, artist, album, emoji, duration;
  final List<Color> colors;
  final bool isLiked;
  final int plays;

  const Track({
    required this.title,
    required this.artist,
    required this.album,
    required this.emoji,
    required this.duration,
    required this.colors,
    this.isLiked = false,
    required this.plays,
  });
}

class Genre {
  final String name, emoji;
  final List<Color> gradient;
  const Genre(this.name, this.emoji, this.gradient);
}

class Artist {
  final String name, emoji, followers;
  final Color accent;
  const Artist(this.name, this.emoji, this.followers, this.accent);
}

// ── Sample Data ───────────────────────────────────────────────
const featuredTrack = Track(
  title: 'Neon Horizon',
  artist: 'LUNA WAVE',
  album: 'Synthetic Dreams',
  emoji: '🌙',
  duration: '3:47',
  colors: [Color(0xFFB14FFF), Color(0xFF4FFFFF)],
  isLiked: true,
  plays: 4200000,
);

const tracks = [
  Track(
    title: 'Midnight Drive',
    artist: 'The Echoes',
    album: 'City Lights',
    emoji: '🚗',
    duration: '4:12',
    colors: [Color(0xFFFF4FBC), Color(0xFFB14FFF)],
    isLiked: true,
    plays: 3100000,
  ),
  Track(
    title: 'Golden Hour',
    artist: 'Solar Drift',
    album: 'Warm Static',
    emoji: '☀️',
    duration: '3:28',
    colors: [Color(0xFFFFD166), Color(0xFFFF6B35)],
    plays: 8700000,
  ),
  Track(
    title: 'Void Signal',
    artist: 'ZERO.X',
    album: 'Dark Matter',
    emoji: '🌌',
    duration: '5:03',
    colors: [Color(0xFF4FFFFF), Color(0xFF2E6BC4)],
    plays: 2400000,
  ),
  Track(
    title: 'Aurora',
    artist: 'Prisma',
    album: 'Light Spectrum',
    emoji: '🌈',
    duration: '3:55',
    colors: [Color(0xFF1DB954), Color(0xFF4FFFFF)],
    isLiked: true,
    plays: 5600000,
  ),
];

const genres = [
  Genre('Electronic', '⚡', [Color(0xFFB14FFF), Color(0xFF4FFFFF)]),
  Genre('Lo-Fi',      '🎧', [Color(0xFFFF4FBC), Color(0xFFB14FFF)]),
  Genre('Hip-Hop',    '🎤', [Color(0xFFFFD166), Color(0xFFFF6B35)]),
  Genre('Ambient',    '🌊', [Color(0xFF4FFFFF), Color(0xFF2E6BC4)]),
  Genre('Jazz',       '🎷', [Color(0xFF1DB954), Color(0xFF0A5C2A)]),
  Genre('Synthwave',  '🌃', [Color(0xFFFF4FBC), Color(0xFF4FFFFF)]),
];

const artists = [
  Artist('LUNA WAVE', '🌙', '4.2M', Color(0xFFB14FFF)),
  Artist('The Echoes', '🎭', '2.8M', Color(0xFFFF4FBC)),
  Artist('Solar Drift', '☀️', '7.1M', Color(0xFFFFD166)),
  Artist('ZERO.X',  '⬛', '1.9M', Color(0xFF4FFFFF)),
];

// ══════════════════════════════════════════════════════════════
//  APP
// ══════════════════════════════════════════════════════════════
class SoundWaveApp extends StatelessWidget {
  const SoundWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBg,
      ),
      home: const MusicHomeScreen(),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  MUSIC HOME SCREEN  (StatefulWidget)
// ══════════════════════════════════════════════════════════════
class MusicHomeScreen extends StatefulWidget {
  const MusicHomeScreen({super.key});

  @override
  State<MusicHomeScreen> createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen>
    with TickerProviderStateMixin {
  int _navIndex = 0;
  bool _isPlaying = false;
  late final AnimationController _vinylController;

  @override
  void initState() {
    super.initState();
    _vinylController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
  }

  @override
  void dispose() {
    _vinylController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _vinylController.repeat();
    } else {
      _vinylController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            MusicTopBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    FeaturedPlayerCard(
                      track: featuredTrack,
                      isPlaying: _isPlaying,
                      vinylController: _vinylController,
                      onTogglePlay: _togglePlay,
                    ),
                    const SizedBox(height: 28),
                    const GenreSection(),
                    const SizedBox(height: 28),
                    const TrendingSection(),
                    const SizedBox(height: 28),
                    const ArtistSection(),
                    const SizedBox(height: 28),
                    const RecentlyPlayedSection(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MusicBottomNav(
        selected: _navIndex,
        onChanged: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  TOP BAR  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class MusicTopBar extends StatelessWidget {
  const MusicTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 8),
      child: Row(
        children: [
          // Logo
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'SOUND',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'WAVE',
                  style: TextStyle(
                    color: kNeon,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Search
          _TopBarBtn(
            icon: Icons.search_rounded,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          // Avatar
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [kNeon, kNeonPink],
              ),
              border: Border.all(color: kNeon, width: 1.5),
            ),
            child: const Center(
              child: Text('🎧', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBarBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _TopBarBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kBorder),
        ),
        child: Icon(icon, color: kWhite80, size: 19),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  FEATURED PLAYER CARD  (StatelessWidget)
// ══════════════════════════════════════════════════════════════


// ── Vinyl record with rotation ────────────────────────────────
class VinylRecord extends StatelessWidget {
  final String emoji;
  final List<Color> colors;
  final AnimationController controller;

  const VinylRecord({
    super.key,
    required this.emoji,
    required this.colors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) => Transform.rotate(
        angle: controller.value * 2 * math.pi,
        child: child,
      ),
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              colors[0].withAlpha(204),
              kBg,
              colors[1].withAlpha(153),
              kBg,
              colors[0].withAlpha(204),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: colors[0].withAlpha(120),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner rings
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBg,
                border: Border.all(color: colors[0].withAlpha(77), width: 1),
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Track info ────────────────────────────────────────────────
class TrackInfo extends StatelessWidget {
  final Track track;
  final Color accentColor;

  const TrackInfo({super.key, required this.track, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accentColor.withAlpha(38),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accentColor.withAlpha(77)),
          ),
          child: Text(
            'NOW PLAYING',
            style: TextStyle(
              color: accentColor,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          track.title,
          style: const TextStyle(
            color: kWhite,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          track.artist,
          style: TextStyle(
            color: accentColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          track.album,
          style: const TextStyle(color: kWhite50, fontSize: 11),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.favorite_rounded, color: kNeonPink, size: 14),
            const SizedBox(width: 5),
            Text(
              '${(track.plays / 1000000).toStringAsFixed(1)}M plays',
              style: const TextStyle(color: kWhite50, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Progress bar ──────────────────────────────────────────────
class PlayerProgressBar extends StatelessWidget {
  const PlayerProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: kWhite10,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.38,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kNeon, kNeonPink],
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: kNeon.withAlpha(153),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.38 - 62 - 6,
              top: -4,
              child: Container(
                width: 11,
                height: 11,
                decoration: const BoxDecoration(
                  color: kWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kNeon,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('1:26', style: TextStyle(color: kWhite50, fontSize: 11)),
            Text('3:47', style: TextStyle(color: kWhite50, fontSize: 11)),
          ],
        ),
      ],
    );
  }
}

// ── Player controls ───────────────────────────────────────────
class PlayerControls extends StatelessWidget {
  final bool isPlaying;
  final Color accentColor;
  final VoidCallback onTogglePlay;

  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.accentColor,
    required this.onTogglePlay,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ControlBtn(icon: Icons.shuffle_rounded, color: kNeon, size: 20),
        _ControlBtn(icon: Icons.skip_previous_rounded, color: kWhite80, size: 28),
        // Play / Pause
        GestureDetector(
          onTap: onTogglePlay,
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kNeon, kNeonPink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kNeon.withAlpha(128),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: kWhite,
              size: 30,
            ),
          ),
        ),
        _ControlBtn(icon: Icons.skip_next_rounded, color: kWhite80, size: 28),
        _ControlBtn(icon: Icons.repeat_rounded, color: kWhite50, size: 20),
      ],
    );
  }
}

class _ControlBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const _ControlBtn({required this.icon, required this.color, required this.size});

  @override
  Widget build(BuildContext context) =>
      Icon(icon, color: color, size: size);
}

// ══════════════════════════════════════════════════════════════
//  GENRE SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════


class GenreChip extends StatelessWidget {
  final Genre genre;
  const GenreChip({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            genre.gradient[0].withAlpha(51),
            genre.gradient[1].withAlpha(204),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: genre.gradient[0].withAlpha(77)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(genre.emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(
            genre.name,
            style: TextStyle(
              color: genre.gradient[0],
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  TRENDING SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

class TrendingCard extends StatelessWidget {
  final Track track;
  final int rank;
  const TrendingCard({super.key, required this.track, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            track.colors[0].withAlpha(55),
            kCard,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: track.colors[0].withAlpha(64)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album art area
          Stack(
            children: [
              Container(
                height: 90,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: track.colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    track.emoji,
                    style: const TextStyle(fontSize: 42),
                  ),
                ),
              ),
              // Rank badge
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: kBg.withAlpha(149),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '#$rank',
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              // Like badge
              if (track.isLiked)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: kBg.withAlpha(180),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_rounded,
                      color: kNeonPink,
                      size: 13,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  track.artist,
                  style: TextStyle(
                    color: track.colors[0],
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      track.duration,
                      style: const TextStyle(color: kWhite50, fontSize: 10),
                    ),
                    Icon(
                      Icons.play_circle_filled_rounded,
                      color: track.colors[0],
                      size: 22,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  ARTIST SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

class ArtistChip extends StatelessWidget {
  final Artist artist;
  const ArtistChip({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                artist.accent,
                artist.accent.withAlpha(77),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: artist.accent.withAlpha(128),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: artist.accent.withAlpha(77),
                blurRadius: 12,
              ),
            ],
          ),
          child: Center(
            child: Text(artist.emoji, style: const TextStyle(fontSize: 28)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          artist.name,
          style: const TextStyle(
            color: kWhite,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          artist.followers,
          style: const TextStyle(color: kWhite50, fontSize: 9),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  RECENTLY PLAYED SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

class RecentTrackRow extends StatelessWidget {
  final Track track;
  final int index;
  const RecentTrackRow({super.key, required this.track, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          // Album art
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: track.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(track.emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      track.artist,
                      style: TextStyle(
                        color: track.colors[0],
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      '  •  ',
                      style: TextStyle(color: kWhite20, fontSize: 11),
                    ),
                    Text(
                      track.duration,
                      style: const TextStyle(color: kWhite50, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          Row(
            children: [
              if (track.isLiked)
                const Icon(Icons.favorite_rounded, color: kNeonPink, size: 16),
              const SizedBox(width: 12),
              Icon(
                Icons.play_circle_outline_rounded,
                color: track.colors[0],
                size: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  BOTTOM NAV  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class MusicBottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const MusicBottomNav({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _icons = [
    Icons.home_rounded,
    Icons.explore_rounded,
    Icons.library_music_rounded,
    Icons.person_outline_rounded,
  ];
  static const _labels = ['Home', 'Discover', 'Library', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: kSurface,
        border: const Border(top: BorderSide(color: kBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(128),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          _icons.length,
              (i) => NavItem(
            icon: _icons[i],
            label: _labels[i],
            isSelected: selected == i,
            accentColor: kNeon,
            onTap: () => onChanged(i),
          ),
        ),
      ),
    );
  }
}

// ── Nav item ──────────────────────────────────────────────────
class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color accentColor;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: isSelected
                    ? accentColor.withAlpha(40)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? accentColor : kWhite50,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? accentColor : kWhite50,
                fontSize: 10,
                fontWeight:
                isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  SHARED WIDGET
// ══════════════════════════════════════════════════════════════
class MusicSectionHeader extends StatelessWidget {
  final String title, action;
  const MusicSectionHeader({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kWhite,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            action,
            style: const TextStyle(
              color: kNeon,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}