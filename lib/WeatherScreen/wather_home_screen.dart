import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:untitled1/WeatherScreen/Widget/weekly_forecast_card.dart';

import 'Widget/air_quality_card.dart';
import 'Widget/hero_weather_card.dart';
import 'Widget/hourly_forecast_card.dart';
import 'Widget/stats_grid.dart';
import 'Widget/top_bar.dart';

void main() => runApp(const WeatherApp());

// ══════════════════════════════════════════════════════════════
//  COLORS & CONSTANTS
// ══════════════════════════════════════════════════════════════
const kSkyTop    = Color(0xFF0D1B3E);
const kSkyMid    = Color(0xFF1A3A6B);
const kSkyAccent = Color(0xFF2E6BC4);
const kSunGold   = Color(0xFFFFD166);
const kWhite     = Color(0xFFFFFFFF);
const kWhite70   = Color(0xB3FFFFFF);
const kWhite40   = Color(0x66FFFFFF);
const kWhite15   = Color(0x26FFFFFF);
const kWhite08   = Color(0x14FFFFFF);

// ══════════════════════════════════════════════════════════════
//  DATA MODELS
// ══════════════════════════════════════════════════════════════
class HourForecast {
  final String time, icon;
  final int temp;
  final bool isNow;
  const HourForecast(this.time, this.icon, this.temp, {this.isNow = false});
}

class DayForecast {
  final String day, icon, condition;
  final int high, low;
  const DayForecast(this.day, this.icon, this.condition, this.high, this.low);
}

class WeatherStat {
  final String label, value, unit;
  final IconData icon;
  const WeatherStat(this.label, this.value, this.unit, this.icon);
}

// ── Sample data ───────────────────────────────────────────────
const hourlyData = [
  HourForecast('Now',   '☀️', 29, isNow: true),
  HourForecast('2 PM',  '⛅', 27),
  HourForecast('4 PM',  '🌤️', 25),
  HourForecast('6 PM',  '🌥️', 22),
  HourForecast('8 PM',  '🌙', 20),
  HourForecast('10 PM', '🌙', 18),
];

const weeklyData =  [
  DayForecast('Today', '☀️', 'Sunny',         29, 18),
  DayForecast('Tue',   '⛅', 'Partly Cloudy', 26, 17),
  DayForecast('Wed',   '🌧️', 'Rainy',         22, 15),
  DayForecast('Thu',   '⛈️', 'Stormy',        20, 14),
  DayForecast('Fri',   '🌤️', 'Clearing',      24, 16),
  DayForecast('Sat',   '☀️', 'Sunny',         28, 17),
  DayForecast('Sun',   '☀️', 'Sunny',         30, 19),
];

const statsData = [
  WeatherStat('Humidity',   '72',  '%',    Icons.water_drop_outlined),
  WeatherStat('Wind',       '14',  'km/h', Icons.air),
  WeatherStat('UV Index',   '7',   '',     Icons.wb_sunny_outlined),
  WeatherStat('Visibility', '10',  'km',   Icons.visibility_outlined),
  WeatherStat('Pressure',   '1013','hPa',  Icons.speed_outlined),
  WeatherStat('Dew Point',  '18',  '°',    Icons.thermostat_outlined),
];

// ══════════════════════════════════════════════════════════════
//  APP
// ══════════════════════════════════════════════════════════════
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kSkyTop,
      ),
      home: const WeatherHomeScreen(),
    );
  }
}

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kSkyTop, kSkyMid, kSkyAccent],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  const TopBar(),
                  const HeroWeatherCard(),
                  const SizedBox(height: 24),
                  const HourlyForecastCard(),
                  const SizedBox(height: 16),
                  const WeeklyForecastCard(),
                  const SizedBox(height: 16),
                  const StatsGrid(),
                  const SizedBox(height: 16),
                  const AirQualityCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ── Sun illustration using CustomPaint ────────────────────────
class SunIllustration extends StatelessWidget {
  const SunIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(painter: _SunPainter()),
    );
  }
}

class _SunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Outer glow
    canvas.drawCircle(
      Offset(cx, cy),
      52,
      Paint()
        ..color = kSunGold.withAlpha(70)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
    );

    // Mid glow
    canvas.drawCircle(
      Offset(cx, cy),
      38,
      Paint()
        ..color = kSunGold.withAlpha(30)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    // Sun body
    canvas.drawCircle(
      Offset(cx, cy),
      26,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0xFFFFE066), kSunGold],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 26)),
    );

    // Rays
    final rayPaint = Paint()
      ..color = kSunGold.withAlpha(70)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) - math.pi / 2;
      final inner = 30.0;
      final outer = 42.0;
      canvas.drawLine(
        Offset(cx + math.cos(angle) * inner, cy + math.sin(angle) * inner),
        Offset(cx + math.cos(angle) * outer, cy + math.sin(angle) * outer),
        rayPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}