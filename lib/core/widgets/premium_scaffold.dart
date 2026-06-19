import 'package:flutter/material.dart';

class PremiumScaffold extends StatelessWidget {
  const PremiumScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? const [Color(0xFF090E1E), Color(0xFF10172F), Color(0xFF151029)]
                    : const [Color(0xFFF8FAFC), Color(0xFFF1F5FF), Color(0xFFFDF7FF)],
              ),
            ),
          ),
        ),
        Positioned(
          top: -120,
          right: -90,
          child: _Glow(size: 260, color: scheme.primary.withOpacity(isDark ? 0.24 : 0.12)),
        ),
        Positioned(
          bottom: 120,
          left: -120,
          child: _Glow(size: 240, color: scheme.tertiary.withOpacity(isDark ? 0.16 : 0.10)),
        ),
        child,
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 90, spreadRadius: 42)],
      ),
    );
  }
}
