import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoadingTiles extends StatelessWidget {
  const LoadingTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        Card.filled(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          child: Shimmer(
            child: const SizedBox(width: 150, height: 34),
          ),
        ),

        Card.filled(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          child: Shimmer(
            child: const SizedBox(width: 100, height: 34),
          ),
        ),

        Card.filled(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          child: Shimmer(
            child: const SizedBox(width: 200, height: 34),
          ),
        ),
      ],
    );
  }
}
