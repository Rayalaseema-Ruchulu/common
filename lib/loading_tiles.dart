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
        Shimmer(
          child: const Card.filled(
            margin: EdgeInsets.all(0),
            child: SizedBox(width: 40, height: 34),
          ),
        ),

        Shimmer(
          child: const Card.filled(
            margin: EdgeInsets.all(0),
            child: SizedBox(width: 20, height: 34),
          ),
        ),

        Shimmer(
          child: const Card.filled(
            margin: EdgeInsets.all(0),
            child: SizedBox(width: 50, height: 34),
          ),
        ),
      ],
    );
  }
}
