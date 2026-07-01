/// Widget de logo compartido.
library;

import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 100,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.how_to_vote_rounded,
      size: size,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
