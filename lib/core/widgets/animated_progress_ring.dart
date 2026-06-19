import 'package:flutter/material.dart';

class AnimatedProgressRing extends StatelessWidget {
  const AnimatedProgressRing({
    required this.value,
    required this.label,
    this.size = 96,
    super.key,
  });

  final double value;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0, 1)),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        return SizedBox.square(
          dimension: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: animatedValue,
                strokeWidth: 10,
                strokeCap: StrokeCap.round,
                backgroundColor: scheme.primary.withOpacity(0.12),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${(animatedValue * 100).round()}%', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  Text(label, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
