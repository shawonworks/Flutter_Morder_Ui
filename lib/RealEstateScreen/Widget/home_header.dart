import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../real_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandLabel(),
              SizedBox(height: 4),
              Text(
                'Find Your\nDream Home',
                style: TextStyle(
                  color: kText,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              NotificationButton(),
              SizedBox(width: 10),
              AvatarButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class BrandLabel extends StatelessWidget {
  const BrandLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 2,
          color: kGold,
          margin: const EdgeInsets.only(right: 8),
        ),
        const Text(
          'ESTATE LUXE',
          style: TextStyle(
            color: kGold,
            fontSize: 11,
            letterSpacing: 4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kDivider),
          ),
          child: const Icon(Icons.notifications_none_rounded, color: kText, size: 20),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: kGold, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
class AvatarButton extends StatelessWidget {
  const AvatarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGold, width: 1.5),
        image: const DecorationImage(
          image: NetworkImage('https://i.pravatar.cc/150?img=12'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}