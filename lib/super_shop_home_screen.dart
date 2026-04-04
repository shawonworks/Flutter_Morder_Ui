import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const SuperShopApp());
}

// ══════════════════════════════════════════════════════════════
//  THEME COLORS
// ══════════════════════════════════════════════════════════════
const kBg         = Color(0xFFF6F7FB);
const kWhite      = Color(0xFFFFFFFF);
const kPrimary    = Color(0xFF1DB954); // fresh green
const kPrimaryDark= Color(0xFF159C42);
const kOrange     = Color(0xFFFF6B35);
const kPurple     = Color(0xFF7C5CBF);
const kBlue       = Color(0xFF2196F3);
const kYellow     = Color(0xFFFFBF00);
const kText       = Color(0xFF1A1D23);
const kTextMuted  = Color(0xFF8A8FA3);
const kCard       = Color(0xFFFFFFFF);
const kDivider    = Color(0xFFEEEFF4);
const kRed        = Color(0xFFE53935);

// ══════════════════════════════════════════════════════════════
//  DATA MODELS
// ══════════════════════════════════════════════════════════════
class Category {
  final String name, emoji;
  final Color bg;
  const Category(this.name, this.emoji, this.bg);
}

class Product {
  final String name, unit, image;
  final double price, oldPrice;
  final double rating;
  final int reviews;
  final bool isOrganic;
  const Product({
    required this.name,
    required this.unit,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.reviews,
    this.isOrganic = false,
  });
}

class Banner {
  final String title, subtitle, cta;
  final Color bgStart, bgEnd;
  final String emoji;
  const Banner(this.title, this.subtitle, this.cta, this.bgStart, this.bgEnd, this.emoji);
}

// ── Sample Data ───────────────────────────────────────────────
const categories = [
  Category('Fruits',     '🍎', Color(0xFFFFF3E0)),
  Category('Vegetables', '🥦', Color(0xFFE8F5E9)),
  Category('Dairy',      '🧀', Color(0xFFFFF8E1)),
  Category('Bakery',     '🍞', Color(0xFFFCE4EC)),
  Category('Beverages',  '🧃', Color(0xFFE3F2FD)),
  Category('Snacks',     '🍿', Color(0xFFF3E5F5)),
  Category('Meat',       '🥩', Color(0xFFFFEBEE)),
  Category('Frozen',     '🧊', Color(0xFFE0F7FA)),
];

const featuredProducts = [
  Product(
    name: 'Organic Strawberry',
    unit: '500g pack',
    image: '🍓',
    price: 180,
    oldPrice: 220,
    rating: 4.8,
    reviews: 312,
    isOrganic: true,
  ),
  Product(
    name: 'Fresh Avocado',
    unit: 'per piece',
    image: '🥑',
    price: 95,
    oldPrice: 120,
    rating: 4.6,
    reviews: 189,
    isOrganic: true,
  ),
  Product(
    name: 'Whole Milk',
    unit: '1 litre',
    image: '🥛',
    price: 75,
    oldPrice: 85,
    rating: 4.9,
    reviews: 540,
  ),
  Product(
    name: 'Multigrain Bread',
    unit: '400g loaf',
    image: '🍞',
    price: 60,
    oldPrice: 70,
    rating: 4.5,
    reviews: 201,
  ),
];

const popularProducts = [
  Product(
    name: 'Cherry Tomato',
    unit: '250g',
    image: '🍅',
    price: 65,
    oldPrice: 80,
    rating: 4.7,
    reviews: 98,
    isOrganic: true,
  ),
  Product(
    name: 'Greek Yogurt',
    unit: '200g',
    image: '🫙',
    price: 110,
    oldPrice: 130,
    rating: 4.8,
    reviews: 445,
  ),
  Product(
    name: 'Orange Juice',
    unit: '1 litre',
    image: '🍊',
    price: 120,
    oldPrice: 145,
    rating: 4.6,
    reviews: 233,
  ),
  Product(
    name: 'Farm Eggs',
    unit: '12 pcs',
    image: '🥚',
    price: 145,
    oldPrice: 160,
    rating: 4.9,
    reviews: 677,
  ),
];

const banners = [
  Banner(
    'Fresh Deals\nEvery Morning',
    'Up to 40% off on Fruits & Veggies',
    'Shop Now',
    Color(0xFF1DB954),
    Color(0xFF0D7A38),
    '🥗',
  ),
  Banner(
    'Dairy Festival\nWeek',
    'Buy 2 get 1 free on all dairy',
    'Grab Offer',
    Color(0xFFFF6B35),
    Color(0xFFCC4400),
    '🧈',
  ),
  Banner(
    'Free Delivery\nOver ৳499',
    'No minimum on your first order',
    'Order Now',
    Color(0xFF7C5CBF),
    Color(0xFF4A2E8F),
    '🚴',
  ),
];

// ══════════════════════════════════════════════════════════════
//  APP
// ══════════════════════════════════════════════════════════════
class SuperShopApp extends StatelessWidget {
  const SuperShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBg,
        colorScheme: const ColorScheme.light(primary: kPrimary),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  HOME SCREEN  (StatefulWidget)
// ══════════════════════════════════════════════════════════════
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  int _bannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            const SearchAndFilter(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    BannerCarousel(
                      currentIndex: _bannerIndex,
                      onPageChanged: (i) => setState(() => _bannerIndex = i),
                    ),
                    const SizedBox(height: 24),
                    const FlashSaleStrip(),
                    const SizedBox(height: 24),
                    const CategorySection(),
                    const SizedBox(height: 24),
                    ProductSection(
                      title: '🔥 Featured Products',
                      subtitle: 'Hand-picked for you',
                      products: featuredProducts,
                    ),
                    const SizedBox(height: 24),
                    const PromoCard(),
                    const SizedBox(height: 24),
                    ProductSection(
                      title: '⭐ Most Popular',
                      subtitle: 'Loved by customers',
                      products: popularProducts,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selected: _navIndex,
        onChanged: (i) => setState(() => _navIndex = i),
      ),
      floatingActionButton: const CartFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  APP HEADER  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      child: Row(
        children: [
          // Logo & location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: kPrimary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'FRESHMART',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: kOrange.withAlpha(120),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'EXPRESS',
                        style: TextStyle(
                          color: kOrange,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const DeliveryLocationRow(),
              ],
            ),
          ),
          // Actions
          const Row(
            children: [
              _HeaderIconBtn(icon: Icons.favorite_border_rounded, badge: 0),
              SizedBox(width: 8),
              _HeaderIconBtn(icon: Icons.notifications_outlined, badge: 3),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Delivery location row ─────────────────────────────────────
class DeliveryLocationRow extends StatelessWidget {
  const DeliveryLocationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.electric_moped_rounded, color: kPrimary, size: 14),
        const SizedBox(width: 4),
        const Text(
          'Deliver to ',
          style: TextStyle(color: kTextMuted, fontSize: 11),
        ),
        const Text(
          'Dhanmondi, Dhaka',
          style: TextStyle(
            color: kText,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Icon(Icons.keyboard_arrow_down_rounded,
            color: kPrimary, size: 15),
      ],
    );
  }
}

// ── Header icon button with badge ────────────────────────────
class _HeaderIconBtn extends StatelessWidget {
  final IconData icon;
  final int badge;
  const _HeaderIconBtn({required this.icon, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: kText, size: 20),
        ),
        if (badge > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: kRed,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  SEARCH & FILTER  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: kBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: kDivider),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 14),
                  Icon(Icons.search_rounded, color: kTextMuted, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Search groceries, brands...',
                    style: TextStyle(color: kTextMuted, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: kPrimary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune_rounded, color: kWhite, size: 20),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  BANNER CAROUSEL  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class BannerCarousel extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const BannerCarousel({
    super.key,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            padEnds: false,
            controller: PageController(viewportFraction: 0.88),
            onPageChanged: onPageChanged,
            itemCount: banners.length,
            itemBuilder: (_, i) => BannerCard(data: banners[i]),
          ),
        ),
        const SizedBox(height: 10),
        BannerDots(total: banners.length, current: currentIndex),
      ],
    );
  }
}

// ── Banner card ───────────────────────────────────────────────
class BannerCard extends StatelessWidget {
  final Banner data;
  const BannerCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, left: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [data.bgStart, data.bgEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          // Big emoji BG decoration
          Positioned(
            right: -10,
            bottom: -10,
            child: Text(
              data.emoji,
              style: const TextStyle(fontSize: 90),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.3,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.subtitle,
                      style: TextStyle(
                        color: kWhite.withAlpha(120),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        data.cta,
                        style: TextStyle(
                          color: data.bgEnd,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Banner dots ───────────────────────────────────────────────
class BannerDots extends StatelessWidget {
  final int total, current;
  const BannerDots({super.key, required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == current ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: i == current ? kPrimary : kDivider,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  FLASH SALE STRIP  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class FlashSaleStrip extends StatelessWidget {
  const FlashSaleStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      decoration: BoxDecoration(
        color: kOrange.withAlpha(9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kOrange.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: kOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.flash_on_rounded, color: kWhite, size: 13),
                SizedBox(width: 2),
                Text(
                  'FLASH SALE',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Ends in 02:45:30 • Up to 50% OFF',
              style: TextStyle(
                color: kOrange,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              color: kOrange, size: 12),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  CATEGORY SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'Shop by Category', actionText: 'All'),
        const SizedBox(height: 14),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => CategoryChip(data: categories[i]),
          ),
        ),
      ],
    );
  }
}

// ── Category chip ─────────────────────────────────────────────
class CategoryChip extends StatelessWidget {
  final Category data;
  const CategoryChip({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: data.bg,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(data.emoji, style: const TextStyle(fontSize: 26)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          data.name,
          style: const TextStyle(
            color: kText,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  PRODUCT SECTION  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class ProductSection extends StatelessWidget {
  final String title, subtitle;
  final List<Product> products;

  const ProductSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, actionText: 'See all'),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 14),
          child: Text(
            subtitle,
            style: const TextStyle(color: kTextMuted, fontSize: 12),
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (_, i) => ProductCard(product: products[i]),
          ),
        ),
      ],
    );
  }
}

// ── Product card ──────────────────────────────────────────────
class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _inCart = false;
  int _qty = 0;

  void _addToCart() => setState(() {
    _inCart = true;
    _qty = 1;
  });

  void _increment() => setState(() => _qty++);
  void _decrement() {
    if (_qty > 1) {
      setState(() => _qty--);
    } else {
      setState(() {
        _inCart = false;
        _qty = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final discount =
    ((1 - widget.product.price / widget.product.oldPrice) * 100).round();

    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Stack(
            children: [
              Container(
                height: 110,
                decoration: const BoxDecoration(
                  color: kBg,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    widget.product.image,
                    style: const TextStyle(fontSize: 54),
                  ),
                ),
              ),
              // Discount badge
              Positioned(
                top: 10,
                left: 10,
                child: DiscountBadge(discount: discount),
              ),
              // Organic badge
              if (widget.product.isOrganic)
                const Positioned(
                  top: 10,
                  right: 10,
                  child: OrganicBadge(),
                ),
            ],
          ),
          // Info
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    color: kText,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.product.unit,
                  style: const TextStyle(color: kTextMuted, fontSize: 11),
                ),
                const SizedBox(height: 6),
                // Rating
                ProductRating(
                  rating: widget.product.rating,
                  reviews: widget.product.reviews,
                ),
                const SizedBox(height: 8),
                // Price + cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '৳${widget.product.price.toInt()}',
                          style: const TextStyle(
                            color: kPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '৳${widget.product.oldPrice.toInt()}',
                          style: const TextStyle(
                            color: kTextMuted,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    _inCart
                        ? CartCounter(
                      qty: _qty,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                    )
                        : AddButton(onTap: _addToCart),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Discount badge ────────────────────────────────────────────
class DiscountBadge extends StatelessWidget {
  final int discount;
  const DiscountBadge({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: kRed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '-$discount%',
        style: const TextStyle(
          color: kWhite,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// ── Organic badge ─────────────────────────────────────────────
class OrganicBadge extends StatelessWidget {
  const OrganicBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: kPrimary.withAlpha(120),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPrimary.withAlpha(30)),
      ),
      child: const Text(
        '🌿 Organic',
        style: TextStyle(
          color: kPrimaryDark,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Product rating ────────────────────────────────────────────
class ProductRating extends StatelessWidget {
  final double rating;
  final int reviews;
  const ProductRating({super.key, required this.rating, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: kYellow, size: 13),
        const SizedBox(width: 2),
        Text(
          '$rating',
          style: const TextStyle(
            color: kText,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          '($reviews)',
          style: const TextStyle(color: kTextMuted, fontSize: 10),
        ),
      ],
    );
  }
}

// ── Add to cart button ────────────────────────────────────────
class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add_rounded, color: kWhite, size: 20),
      ),
    );
  }
}

// ── Cart counter (qty +/-) ────────────────────────────────────
class CartCounter extends StatelessWidget {
  final int qty;
  final VoidCallback onIncrement, onDecrement;

  const CartCounter({
    super.key,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: kPrimary.withAlpha(15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimary.withAlpha(14)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CounterBtn(icon: Icons.remove_rounded, onTap: onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$qty',
              style: const TextStyle(
                color: kPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          _CounterBtn(icon: Icons.add_rounded, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _CounterBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CounterBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Icon(icon, color: kPrimary, size: 16),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  PROMO CARD  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1DB954), Color(0xFF0D5C2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get ৳50 OFF',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'On your first order above ৳299\nUse code: FRESH50',
                  style: TextStyle(
                    color: Color(0xCCFFFFFF),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 14),
                _PromoCtaBtn(),
              ],
            ),
          ),
          const Text('🎁', style: TextStyle(fontSize: 64)),
        ],
      ),
    );
  }
}

class _PromoCtaBtn extends StatelessWidget {
  const _PromoCtaBtn();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Claim Offer →',
        style: TextStyle(
          color: kPrimaryDark,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  BOTTOM NAV  (StatelessWidget)
// ══════════════════════════════════════════════════════════════
class BottomNavBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const BottomNavBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _icons = [
    Icons.home_rounded,
    Icons.grid_view_rounded,
    Icons.receipt_long_outlined,
    Icons.person_outline_rounded,
  ];
  static const _labels = ['Home', 'Categories', 'Orders', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(6),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left two items
          ...List.generate(2, (i) => _NavItem(
            icon: _icons[i],
            label: _labels[i],
            isSelected: selected == i,
            onTap: () => onChanged(i),
          )),
          // Center gap for FAB
          const Expanded(child: SizedBox()),
          // Right two items
          ...List.generate(2, (i) => _NavItem(
            icon: _icons[i + 2],
            label: _labels[i + 2],
            isSelected: selected == i + 2,
            onTap: () => onChanged(i + 2),
          )),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
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
            Icon(
              icon,
              color: isSelected ? kPrimary : kTextMuted,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? kPrimary : kTextMuted,
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

// ── Cart FAB ──────────────────────────────────────────────────
class CartFab extends StatelessWidget {
  const CartFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kPrimary, kPrimaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kPrimary.withAlpha(40),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.shopping_cart_rounded, color: kWhite, size: 26),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: kOrange,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '4',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  SHARED WIDGETS
// ══════════════════════════════════════════════════════════════

// ── Section header ────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title, actionText;

  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kText,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: kPrimary.withAlpha(10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              actionText,
              style: const TextStyle(
                color: kPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}