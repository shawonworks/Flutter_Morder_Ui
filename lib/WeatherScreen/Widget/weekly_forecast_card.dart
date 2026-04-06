import 'package:flutter/material.dart';
import '../wather_home_screen.dart';
import 'hourly_forecast_card.dart';

class WeeklyForecastCard extends StatelessWidget {
  const WeeklyForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const CardLabel(icon: Icons.calendar_today_rounded, text: '7-DAY FORECAST'),
          const SizedBox(height: 12),
          ...weeklyData.map((d) => DayForecastRow(data: d)),
        ],
      ),
    );
  }
}

// ── Day forecast row ──────────────────────────────────────────
class DayForecastRow extends StatelessWidget

{
  final DayForecast data;
  const DayForecastRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              data.day,
              style: const TextStyle(
                  color: kWhite, fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          Text(data.icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(data.condition,
                style: const TextStyle(color: kWhite70, fontSize: 12)),
          ),
          // Temp bar
          Expanded(child: _TempBar(high: data.high, low: data.low)),
          const SizedBox(width: 10),
          Text('${data.high}°',
              style: const TextStyle(
                  color: kWhite, fontSize: 13, fontWeight: FontWeight.w600)),
          Text(' / ${data.low}°',
              style: const TextStyle(color: kWhite40, fontSize: 12)),
        ],
      ),
    );
  }
}

// ── Temp bar ──────────────────────────────────────────────────
class _TempBar extends StatelessWidget {
  final int high, low;
  const _TempBar({required this.high, required this.low});

  @override
  Widget build(BuildContext context) {
    final pct = (high - 15) / 20.0;
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: kWhite15,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: pct.clamp(0.1, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4FC3F7), kSunGold],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}