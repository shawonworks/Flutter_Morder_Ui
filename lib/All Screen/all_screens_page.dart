import 'package:flutter/material.dart';

// ══════════════════════════════════════════════════════════════
//  COLORS
// ══════════════════════════════════════════════════════════════
const kBg      = Color(0xFF0F0F17);
const kCard    = Color(0xFF1A1A28);
const kBorder  = Color(0xFF2A2A3E);
const kWhite   = Color(0xFFFFFFFF);
const kWhite60 = Color(0x99FFFFFF);
const kWhite30 = Color(0x4DFFFFFF);

// ══════════════════════════════════════════════════════════════
//  SCREEN ITEM DATA MODEL
// ══════════════════════════════════════════════════════════════
class ScreenItem {
  final String title, subtitle, emoji;
  final List<Color> gradient;
  final Color glow;

  const ScreenItem({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradient,
    required this.glow,
  });
}

const screens = [
  ScreenItem(
    title: 'Real Estate',
    subtitle: 'Luxury property finder',
    emoji: '🏙️',
    gradient: [Color(0xFFC9A84C), Color(0xFF8B5E1A)],
    glow: Color(0xFFC9A84C),
  ),
  ScreenItem(
    title: 'Weather App',
    subtitle: 'Live sky conditions',
    emoji: '🌤️',
    gradient: [Color(0xFF2E6BC4), Color(0xFF0D1B3E)],
    glow: Color(0xFF4FC3F7),
  ),
  ScreenItem(
    title: 'Super Shop',
    subtitle: 'Fresh grocery market',
    emoji: '🛒',
    gradient: [Color(0xFF1DB954), Color(0xFF0A5C2A)],
    glow: Color(0xFF1DB954),
  ),
];

// ══════════════════════════════════════════════════════════════
//  ALL SCREENS PAGE  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class AllScreensPage extends StatelessWidget {
  /// Pass the 3 target screen widgets from main.dart
  final List<Widget> destinations;

  const AllScreensPage({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const LauncherHeader(),
              const SizedBox(height: 48),
              Expanded(
                child: ScreenButtonList(destinations: destinations),
              ),
              const LauncherFooter(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  LAUNCHER HEADER  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class LauncherHeader extends StatelessWidget {
  const LauncherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Active pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBorder),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PulseDot(),
              SizedBox(width: 7),
              Text(
                'DEV SHOWCASE',
                style: TextStyle(
                  color: kWhite60,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // Big title
        const Text(
          'All\nScreens',
          style: TextStyle(
            color: kWhite,
            fontSize: 52,
            fontWeight: FontWeight.w800,
            height: 1.0,
            letterSpacing: -2.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Tap any card to explore the screen',
          style: TextStyle(color: kWhite60, fontSize: 14),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  PULSE DOT  (StatefulWidget)
// ══════════════════════════════════════════════════════════════
class PulseDot extends StatefulWidget {
  const PulseDot({super.key});

  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.35, end: 1.0)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 7,
        height: 7,
        decoration: const BoxDecoration(
          color: Color(0xFF1DB954),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  SCREEN BUTTON LIST  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class ScreenButtonList extends StatelessWidget {
  final List<Widget> destinations;

  const ScreenButtonList({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: screens.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => ScreenButton(
        item: screens[i],
        destination: destinations[i],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  SCREEN BUTTON  (StatefulWidget — press scale animation)
// ══════════════════════════════════════════════════════════════
class ScreenButton extends StatefulWidget {
  final ScreenItem item;
  final Widget destination;

  const ScreenButton({
    super.key,
    required this.item,
    required this.destination,
  });

  @override
  State<ScreenButton> createState() => _ScreenButtonState();
}

class _ScreenButtonState extends State<ScreenButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _onTapDown(_) => _c.forward();
  void _onTapUp(_) => _c.reverse();
  void _onTapCancel() => _c.reverse();

  void _navigate() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, __) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: widget.destination,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _navigate,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: kBorder),
            boxShadow: [
              BoxShadow(
                color: item.glow.withOpacity(0.12),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              // Gradient icon box
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: item.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: item.glow.withOpacity(0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    item.emoji,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        color: kWhite60,
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Glow pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          item.glow.withOpacity(0.22),
                          item.glow.withOpacity(0.04),
                        ]),
                        borderRadius: BorderRadius.circular(10),
                        border:
                        Border.all(color: item.glow.withOpacity(0.28)),
                      ),
                      child: Text(
                        'Open Screen  →',
                        style: TextStyle(
                          color: item.glow,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Arrow icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: item.glow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: item.glow,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  LAUNCHER FOOTER  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class LauncherFooter extends StatelessWidget {
  const LauncherFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 32, height: 1, color: kBorder),
        const SizedBox(width: 12),
        const Text(
          '3 screens available',
          style: TextStyle(color: kWhite30, fontSize: 11),
        ),
        const SizedBox(width: 12),
        Container(width: 32, height: 1, color: kBorder),
      ],
    );
  }
}