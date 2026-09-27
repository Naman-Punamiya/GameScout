import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  final List<Widget> avatars;
  final double overlap;
  final double height;

  const AvatarStack({
    super.key,
    required this.avatars,
    this.overlap = 16.0,
    this.height = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    if (avatars.isEmpty) return const SizedBox.shrink();

    final itemWidth = height;
    final totalWidth = itemWidth + (avatars.length - 1) * overlap;

    return SizedBox(
      width: totalWidth,
      height: height,
      child: Stack(
        children: [
          for (int i = 0; i < avatars.length; i++)
            Positioned(left: i * overlap, child: avatars[i]),
        ],
      ),
    );
  }
}
