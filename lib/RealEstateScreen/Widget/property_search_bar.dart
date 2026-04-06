import 'package:flutter/material.dart';
import '../../All Screen/all_screens_page.dart';
import '../../MusicScreen/music_home_screen.dart' hide kCard;
import '../../SuperShop/super_shop_home_screen.dart' hide kCard;
import '../real_state.dart' hide kTextMuted, kCard, kGold, kDivider;

class PropertySearchBar extends StatelessWidget {
  const PropertySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: kDivider),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search_rounded, color: kGold, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Search properties...',
                    style: TextStyle(color: kTextMuted, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kGold, kGoldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.tune_rounded, color: Color(0xFF1A1400), size: 22),
          ),
        ],
      ),
    );
  }
}