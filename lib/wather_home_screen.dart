import 'dart:math' as math;
import 'package:flutter/material.dart';

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

const weeklyData = [
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

// ══════════════════════════════════════════════════════════════
//  HOME SCREEN  (StatefulWidget)
// ══════════════════════════════════════════════════════════════
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

// ══════════════════════════════════════════════════════════════
//  TOP BAR  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

// ══════════════════════════════════════════════════════════════
//  HERO WEATHER CARD  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

// ══════════════════════════════════════════════════════════════
//  HOURLY FORECAST CARD  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (_, i) => HourlyItem(data: hourlyData[i]),
            ),
          ),
        ],
      ),
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

// ══════════════════════════════════════════════════════════════
//  WEEKLY FORECAST CARD  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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
class DayForecastRow extends StatelessWidget {
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

// ══════════════════════════════════════════════════════════════
//  STATS GRID  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

// ══════════════════════════════════════════════════════════════
//  AIR QUALITY CARD  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
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

// ══════════════════════════════════════════════════════════════
//  SHARED WIDGETS
// ══════════════════════════════════════════════════════════════

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