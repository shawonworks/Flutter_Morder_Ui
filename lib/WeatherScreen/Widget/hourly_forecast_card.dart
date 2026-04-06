import 'package:flutter/material.dart';

import '../wather_home_screen.dart';

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardLabel(icon: Icons.access_time_rounded, text: 'HOURLY FORECAST'),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (_, i) => HourlyItem(data: hourlyData[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Glass card container ──────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;

  const GlassCard({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kWhite08,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kWhite15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}



// ── Card section label ────────────────────────────────────────
class CardLabel extends StatelessWidget {
  final IconData icon;
  final String text;

  const CardLabel({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kWhite40, size: 14),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: kWhite40,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

// ── Hourly item ───────────────────────────────────────────────
class HourlyItem extends StatelessWidget {
  final HourForecast data;
  const HourlyItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 62,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: data.isNow ? kWhite15 : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: data.isNow ? Border.all(color: kWhite40) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(data.time,
              style: TextStyle(
                color: data.isNow ? kWhite : kWhite70,
                fontSize: 11,
                fontWeight: data.isNow ? FontWeight.w700 : FontWeight.w400,
              )),
          Text(data.icon, style: const TextStyle(fontSize: 22)),
          Text('${data.temp}°',
              style: TextStyle(
                color: data.isNow ? kSunGold : kWhite,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}