import 'package:flutter/material.dart';

import 'Widget/featured_section.dart';
import 'Widget/home_header.dart';
import 'Widget/property_search_bar.dart';

void main() => runApp(const RealEstateApp());

// ── Colors ────────────────────────────────────────────────────
const kBg = Color(0xFF0A0A0F);
const kSurface = Color(0xFF13131A);
const kCard = Color(0xFF1C1C26);
const kGold = Color(0xFFC9A84C);
const kGoldLight = Color(0xFFE8C97A);
const kText = Color(0xFFF0EDE8);
const kTextMuted = Color(0xFF8A8799);
const kDivider = Color(0xFF2A2A38);

// ── Data Model ────────────────────────────────────────────────
class Property {
  final String title, location, price, image, tag;
  final int beds, baths;
  final double sqft;

  const Property({
    required this.title,
    required this.location,
    required this.price,
    required this.image,
    required this.tag,
    required this.beds,
    required this.baths,
    required this.sqft,
  });
}

// ── Sample Data ───────────────────────────────────────────────
final List<Property> featuredProperties = [
  const Property(
    title: 'Skyline Penthouse',
    location: 'Manhattan, New York',
    price: '\$12,500,000',
    image: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
    tag: 'FEATURED',
    beds: 4,
    baths: 5,
    sqft: 4200,
  ),
  const Property(
    title: 'Azure Villa',
    location: 'Malibu, California',
    price: '\$8,900,000',
    image: 'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800',
    tag: 'NEW',
    beds: 5,
    baths: 6,
    sqft: 5800,
  ),
  const Property(
    title: 'The Crown Residences',
    location: 'Miami Beach, Florida',
    price: '\$4,200,000',
    image: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
    tag: 'HOT',
    beds: 3,
    baths: 4,
    sqft: 2900,
  ),
];

final List<Property> nearbyProperties = [
  const Property(
    title: 'Garden Estate',
    location: 'Beverly Hills, CA',
    price: '\$6,100,000',
    image: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=600',
    tag: 'EXCLUSIVE',
    beds: 6,
    baths: 7,
    sqft: 7200,
  ),
  const Property(
    title: 'Urban Loft 360',
    location: 'Chicago, Illinois',
    price: '\$2,300,000',
    image: 'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=600',
    tag: 'SALE',
    beds: 2,
    baths: 2,
    sqft: 1800,
  ),
];

// ══════════════════════════════════════════════════════════════
//  APP
// ══════════════════════════════════════════════════════════════
class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBg,
        colorScheme: const ColorScheme.dark(primary: kGold, surface: kSurface),
      ),
      home: const HomeScreen(),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  HOME SCREEN  (StatefulWidget — nav & category state)
// ══════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNav = 0;
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PropertySearchBar(),
                    CategoryBar(
                      selected: _selectedCategory,
                      onSelected: (i) => setState(() => _selectedCategory = i),
                    ),
                    FeaturedSection(properties: featuredProperties),
                    const StatsRow(),
                    NearbySection(properties: nearbyProperties),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        selected: _selectedNav,
        onChanged: (i) => setState(() => _selectedNav = i),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  CATEGORY BAR  (StatelessWidget — state lifted to HomeScreen)
// ══════════════════════════════════════════════════════════════
class CategoryBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelected;

  const CategoryBar({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _categories = ['All', 'Penthouse', 'Villa', 'Duplex', 'Studio'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: _categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (_, i) => CategoryChip(
            label: _categories[i],
            isSelected: selected == i,
            onTap: () => onSelected(i),
          ),
        ),
      ),
    );
  }
}

// ── Category chip ─────────────────────────────────────────────
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kGold : kCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? kGold : kDivider),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1A1400) : kTextMuted,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  FEATURED SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════

// ── Featured card ─────────────────────────────────────────────
class FeaturedCard extends StatelessWidget {
  final Property property;

  const FeaturedCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: kCard,
        border: Border.all(color: kDivider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PropertyNetworkImage(url: property.image),
          const CardGradientOverlay(),
          Positioned(top: 14, left: 14, child: TagBadge(tag: property.tag)),
          const Positioned(top: 12, right: 12, child: FavouriteButton()),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FeaturedCardInfo(property: property),
          ),
        ],
      ),
    );
  }
}

// ── Property image with placeholder ──────────────────────────
class PropertyNetworkImage extends StatelessWidget {
  final String url;

  const PropertyNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, progress) =>
          progress == null ? child : Container(color: kCard),
      errorBuilder: (_, _, _) => Container(
        color: kCard,
        child: const Icon(Icons.home_outlined, color: kDivider, size: 40),
      ),
    );
  }
}

// ── Gradient overlay ──────────────────────────────────────────
class CardGradientOverlay extends StatelessWidget {
  const CardGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Color(0xCC0A0A0F)],
          stops: [0.35, 1.0],
        ),
      ),
    );
  }
}

// ── Tag badge ─────────────────────────────────────────────────
class TagBadge extends StatelessWidget {
  final String tag;
  final double fontSize;
  final EdgeInsets padding;

  const TagBadge({
    super.key,
    required this.tag,
    this.fontSize = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: kGold,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: const Color(0xFF1A1400),
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ── Favourite button ──────────────────────────────────────────
class FavouriteButton extends StatelessWidget {
  const FavouriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: kBg.withAlpha(80),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.favorite_border_rounded, color: kText, size: 16),
    );
  }
}

// ── Featured card bottom info ─────────────────────────────────
class FeaturedCardInfo extends StatelessWidget {
  final Property property;

  const FeaturedCardInfo({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.title,
          style: const TextStyle(
            color: kText,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        LocationRow(location: property.location),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              property.price,
              style: const TextStyle(
                color: kGold,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                MiniStat(icon: Icons.bed_outlined, value: '${property.beds}'),
                const SizedBox(width: 8),
                MiniStat(
                  icon: Icons.bathtub_outlined,
                  value: '${property.baths}',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  STATS ROW  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 28, 24, 0),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1800), Color(0xFF1C1C26)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kGold.withAlpha(40)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatItem(value: '12K+', label: 'Properties'),
          StatDivider(),
          StatItem(value: '98%', label: 'Satisfaction'),
          StatDivider(),
          StatItem(value: '15+', label: 'Awards'),
        ],
      ),
    );
  }
}

// ── Stat item ─────────────────────────────────────────────────
class StatItem extends StatelessWidget {
  final String value, label;

  const StatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: kGold,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: kTextMuted, fontSize: 11)),
      ],
    );
  }
}

// ── Divider between stats ─────────────────────────────────────
class StatDivider extends StatelessWidget {
  const StatDivider({super.key});

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: kDivider);
}

// ══════════════════════════════════════════════════════════════
//  NEARBY SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class NearbySection extends StatelessWidget {
  final List<Property> properties;

  const NearbySection({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Nearby Properties', action: 'Map View'),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: properties.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (_, i) => NearbyCard(property: properties[i]),
        ),
      ],
    );
  }
}

// ── Nearby card ───────────────────────────────────────────────
class NearbyCard extends StatelessWidget {
  final Property property;

  const NearbyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDivider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 108,
            child: Stack(
              fit: StackFit.expand,
              children: [
                PropertyNetworkImage(url: property.image),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: TagBadge(
                    tag: property.tag,
                    fontSize: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: NearbyCardInfo(property: property)),
        ],
      ),
    );
  }
}

// ── Nearby card info ──────────────────────────────────────────
class NearbyCardInfo extends StatelessWidget {
  final Property property;

  const NearbyCardInfo({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            property.title,
            style: const TextStyle(
              color: kText,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          LocationRow(location: property.location),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                property.price,
                style: const TextStyle(
                  color: kGold,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  MiniStat(icon: Icons.bed_outlined, value: '${property.beds}'),
                  const SizedBox(width: 8),
                  MiniStat(
                    icon: Icons.square_foot_outlined,
                    value: '${property.sqft.toInt()}ft²',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  SHARED SMALL WIDGETS
// ══════════════════════════════════════════════════════════════

// ── Location row ──────────────────────────────────────────────
class LocationRow extends StatelessWidget {
  final String location;

  const LocationRow({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: kGold, size: 12),
        const SizedBox(width: 3),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(color: kTextMuted, fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ── Mini stat (icon + value) ──────────────────────────────────
class MiniStat extends StatelessWidget {
  final IconData icon;
  final String value;

  const MiniStat({super.key, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kTextMuted, size: 12),
        const SizedBox(width: 3),
        Text(value, style: const TextStyle(color: kTextMuted, fontSize: 11)),
      ],
    );
  }
}

// ── Section header ────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title, action;

  const SectionHeader({super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kText,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          Text(
            action,
            style: const TextStyle(
              color: kGold,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  BOTTOM NAV  (StatelessWidget — state lifted to HomeScreen)
// ══════════════════════════════════════════════════════════════
class BottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const BottomNav({super.key, required this.selected, required this.onChanged});

  static const _icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.favorite_border_rounded,
    Icons.person_outline_rounded,
  ];
  static const _labels = ['Home', 'Explore', 'Saved', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: kSurface,
        border: const Border(top: BorderSide(color: kDivider)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          _icons.length,
          (i) => NavItem(
            icon: _icons[i],
            label: _labels[i],
            isSelected: selected == i,
            onTap: () => onChanged(i),
          ),
        ),
      ),
    );
  }
}

// ── Single nav item ───────────────────────────────────────────
class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? kGold.withAlpha(80) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? kGold : kTextMuted,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? kGold : kTextMuted,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
