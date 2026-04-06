import 'package:flutter/material.dart';

import '../wather_home_screen.dart';
import 'hourly_forecast_card.dart';

class AirQualityCard extends StatelessWidget {
  const AirQualityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardLabel(icon: Icons.eco_outlined, text: 'AIR QUALITY'),
          const SizedBox(height: 16),
          Row(
            children: [
              // AQI score
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF66BB6A), width: 2.5),
                  color: const Color(0xFF66BB6A).withAlpha(60),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('42',
                        style: TextStyle(
                            color: Color(0xFF66BB6A),
                            fontSize: 20,
                            fontWeight: FontWeight.w800)),
                    Text('AQI',
                        style: TextStyle(color: kWhite40, fontSize: 9)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: _AirQualityInfo()),
            ],
          ),
          const SizedBox(height: 16),
          const _AirProgressBar(label: 'PM2.5', value: 0.28, color: Color(0xFF66BB6A)),
          const SizedBox(height: 10),
          const _AirProgressBar(label: 'PM10',  value: 0.42, color: Color(0xFFFFCA28)),
          const SizedBox(height: 10),
          const _AirProgressBar(label: 'O₃',    value: 0.18, color: Color(0xFF4FC3F7)),
        ],
      ),
    );
  }
}


class _AirQualityInfo extends StatelessWidget {
  const _AirQualityInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Good',
            style: TextStyle(
                color: Color(0xFF66BB6A),
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Air quality is satisfactory and poses little or no risk.',
          style: TextStyle(color: kWhite40, fontSize: 11.5, height: 1.4),
        ),
      ],
    );
  }
}



class _AirProgressBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _AirProgressBar({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 36,
          child: Text(label,
              style: const TextStyle(color: kWhite70, fontSize: 11)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                  color: kWhite15,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text('${(value * 100).toInt()}',
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}