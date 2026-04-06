import 'package:flutter/cupertino.dart';

import '../real_state.dart';

class FeaturedSection extends StatelessWidget {
  final List<Property> properties;

  const FeaturedSection({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Featured', action: 'See all'),
        SizedBox(
          height: 290,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: properties.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (_, i) => FeaturedCard(property: properties[i]),
          ),
        ),
      ],
    );
  }
}