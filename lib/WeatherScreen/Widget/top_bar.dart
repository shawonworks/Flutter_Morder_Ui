import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wather_home_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LocationInfo(),
          Row(
            children: [
              _GlassIconBtn(icon: Icons.search_rounded),
              const SizedBox(width: 10),
              _GlassIconBtn(icon: Icons.more_vert_rounded),
            ],
          ),
        ],
      ),
    );
  }
}
// ── Glass icon button ─────────────────────────────────────────
class _GlassIconBtn extends StatelessWidget {
  final IconData icon;
  const _GlassIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: kWhite15,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kWhite15),
      ),
      child: Icon(icon, color: kWhite, size: 20),
    );
  }
}

// ── Location info ─────────────────────────────────────────────
class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on_rounded, color: kSunGold, size: 16),
            const SizedBox(width: 4),
            const Text(
              'Dhaka, Bangladesh',
              style: TextStyle(
                color: kWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: kWhite70, size: 18),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          'Thursday, 3 April 2026',
          style: TextStyle(color: kWhite40, fontSize: 12),
        ),
      ],
    );
  }
}