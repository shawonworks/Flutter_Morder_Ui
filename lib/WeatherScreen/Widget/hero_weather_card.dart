import 'package:flutter/cupertino.dart';

import '../wather_home_screen.dart';

class HeroWeatherCard extends StatelessWidget {
  const HeroWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        children: [
          // Sun illustration
          const SunIllustration(),
          const SizedBox(height: 20),
          // Temperature
          const Text(
            '29°',
            style: TextStyle(
              color: kWhite,
              fontSize: 90,
              fontWeight: FontWeight.w200,
              height: 1.0,
              letterSpacing: -4,
            ),
          ),
          const SizedBox(height: 4),
          // Condition
          const Text(
            'Sunny & Clear',
            style: TextStyle(
              color: kWhite70,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          // High / Low
          const _HighLowRow(),
          const SizedBox(height: 20),
          // Feels like pill
          const _FeelsLikePill(),
        ],
      ),
    );
  }
}

// ── High / Low row ────────────────────────────────────────────
class _HighLowRow extends StatelessWidget {
  const _HighLowRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TempBadge(label: 'H', value: '32°', color: kSunGold),
        Container(
          width: 1,
          height: 14,
          color: kWhite40,
          margin: const EdgeInsets.symmetric(horizontal: 14),
        ),
        _TempBadge(label: 'L', value: '18°', color: kWhite70),
      ],
    );
  }
}

class _TempBadge extends StatelessWidget {
  final String label, value;
  final Color color;
  const _TempBadge({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(width: 4),
        Text(value,
            style: const TextStyle(
                color: kWhite, fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ── Feels like pill ───────────────────────────────────────────
class _FeelsLikePill extends StatelessWidget {
  const _FeelsLikePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: kWhite08,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kWhite15),
      ),
      child: const Text(
        'Feels like 31°  •  Sunrise 6:02 AM  •  Sunset 6:44 PM',
        style: TextStyle(color: kWhite70, fontSize: 11.5, letterSpacing: 0.2),
      ),
    );
  }
}