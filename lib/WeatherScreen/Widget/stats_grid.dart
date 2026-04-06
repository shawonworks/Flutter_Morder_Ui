import 'package:flutter/cupertino.dart';

import '../wather_home_screen.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(children: [
            Expanded(child: StatTile(data: statsData[0])),
            const SizedBox(width: 12),
            Expanded(child: StatTile(data: statsData[1])),
            const SizedBox(width: 12),
            Expanded(child: StatTile(data: statsData[2])),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: StatTile(data: statsData[3])),
            const SizedBox(width: 12),
            Expanded(child: StatTile(data: statsData[4])),
            const SizedBox(width: 12),
            Expanded(child: StatTile(data: statsData[5])),
          ]),
        ],
      ),
    );
  }
}

// ── Stat tile ─────────────────────────────────────────────────
class StatTile extends StatelessWidget {
  final WeatherStat data;
  const StatTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite08,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kWhite15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, color: kWhite40, size: 18),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.value,
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
              if (data.unit.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 2),
                  child: Text(data.unit,
                      style: const TextStyle(
                          color: kWhite70, fontSize: 11)),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(data.label,
              style: const TextStyle(color: kWhite40, fontSize: 11)),
        ],
      ),
    );
  }
}