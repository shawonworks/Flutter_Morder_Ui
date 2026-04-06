import 'package:flutter/material.dart';

// ══════════════════════════════════════════════════════════════
//  COLORS
// ══════════════════════════════════════════════════════════════
const kBg      = Color(0xFF08080F);
const kCard    = Color(0xFF131320);
const kBorder  = Color(0xFF252540);
const kWhite   = Color(0xFFFFFFFF);
const kWhite60 = Color(0x99FFFFFF);
const kWhite30 = Color(0x4DFFFFFF);
const kWhite10 = Color(0x1AFFFFFF);

// ══════════════════════════════════════════════════════════════
//  DATA MODEL
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

// ── 4 screens data ────────────────────────────────────────────
const screens = [
  ScreenItem(
    title: 'Real Estate',
    subtitle: 'Luxury property finder',
    emoji: '🏙️',
    gradient: [Color(0xFFC9A84C), Color(0xFF6B3F0A)],
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
    gradient: [Color(0xFF1DB954), Color(0xFF0A4A22)],
    glow: Color(0xFF1DB954),
  ),
  ScreenItem(
    title: 'Music Stream',
    subtitle: 'Neon sound experience',
    emoji: '🎵',
    gradient: [Color(0xFFB14FFF), Color(0xFF3A0080)],
    glow: Color(0xFFB14FFF),
  ),
];

// ══════════════════════════════════════════════════════════════
//  ALL SCREENS PAGE  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class AllScreensPage extends StatelessWidget {
  final List<Widget> destinations;

  const AllScreensPage({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        children: [
          // Background ambient glows
          const _AmbientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 36),
                  const LauncherHeader(),
                  const SizedBox(height: 36),
                  Expanded(
                    child: ScreenButtonList(destinations: destinations),
                  ),
                  LauncherFooter(count: destinations.length),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ambient background glow blobs ─────────────────────────────
class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-left purple glow
        Positioned(
          top: -80,
          left: -60,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFB14FFF).withAlpha(42),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Bottom-right gold glow
        Positioned(
          bottom: -60,
          right: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFC9A84C).withAlpha(42),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: kWhite10,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBorder),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PulseDot(),
              SizedBox(width: 8),
              Text(
                'DEV SHOWCASE',
                style: TextStyle(
                  color: kWhite60,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Big title
        const Text(
          'All\nScreens',
          style: TextStyle(
            color: kWhite,
            fontSize: 54,
            fontWeight: FontWeight.w900,
            height: 0.95,
            letterSpacing: -3,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Tap any card to explore the screen',
          style: TextStyle(
            color: kWhite60,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
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
    _anim = Tween<double>(begin: 0.3, end: 1.0)
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
          color: Color(0xFFB14FFF),
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
      physics: const BouncingScrollPhysics(),
      itemCount: screens.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) => ScreenButton(
        item: screens[i],
        destination: destinations[i],
        index: i,
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
  final int index;

  const ScreenButton({
    super.key,
    required this.item,
    required this.destination,
    required this.index,
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
        transitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (_, animation, __) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
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
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: item.glow.withAlpha(51),
            ),
            boxShadow: [
              BoxShadow(
                color: item.glow.withAlpha(26),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Gradient icon box
              _IconBox(item: item),
              const SizedBox(width: 16),
              // Text info
              Expanded(child: _CardText(item: item)),
              const SizedBox(width: 10),
              // Arrow
              _ArrowBox(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Icon box ──────────────────────────────────────────────────
class _IconBox extends StatelessWidget {
  final ScreenItem item;
  const _IconBox({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: item.glow.withAlpha(120),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(item.emoji, style: const TextStyle(fontSize: 30)),
      ),
    );
  }
}

// ── Card text (title + subtitle + pill) ───────────────────────
class _CardText extends StatelessWidget {
  final ScreenItem item;
  const _CardText({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: const TextStyle(
            color: kWhite,
            fontSize: 17,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          item.subtitle,
          style: const TextStyle(
            color: kWhite60,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        // Glow pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              item.glow.withAlpha(60),
              item.glow.withAlpha(102),
            ]),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: item.glow.withAlpha(77)),
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
    );
  }
}

// ── Arrow box ─────────────────────────────────────────────────
class _ArrowBox extends StatelessWidget {
  final ScreenItem item;
  const _ArrowBox({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: item.glow.withAlpha(26),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: item.glow.withAlpha(51)),
      ),
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        color: item.glow,
        size: 13,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  LAUNCHER FOOTER  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class LauncherFooter extends StatelessWidget {
  final int count;
  const LauncherFooter({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 32, height: 1, color: kBorder),
        const SizedBox(width: 12),
        Text(
          '$count screens available',
          style: const TextStyle(color: kWhite30, fontSize: 11),
        ),
        const SizedBox(width: 12),
        Container(width: 32, height: 1, color: kBorder),
      ],
    );
  }
}