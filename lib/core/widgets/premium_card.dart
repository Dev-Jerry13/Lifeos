import 'dart:ui';

import 'package:flutter/material.dart';

class PremiumCard extends StatefulWidget {
  const PremiumCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.accented = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool accented;

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;
    return GestureDetector(
      onTapDown: widget.onTap == null ? null : (_) => setState(() => _pressed = true),
      onTapCancel: widget.onTap == null ? null : () => setState(() => _pressed = false),
      onTapUp: widget.onTap == null ? null : (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.985 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(28),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  padding: widget.padding,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.accented
                          ? [scheme.primary.withOpacity(0.92), scheme.secondary.withOpacity(0.86)]
                          : [
                              scheme.surface.withOpacity(isDark ? 0.74 : 0.92),
                              scheme.surfaceContainerHighest.withOpacity(isDark ? 0.34 : 0.58),
                            ],
                    ),
                    border: Border.all(
                      color: widget.accented ? Colors.white.withOpacity(0.18) : scheme.outlineVariant.withOpacity(0.42),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.accented
                            ? scheme.primary.withOpacity(isDark ? 0.28 : 0.18)
                            : Colors.black.withOpacity(isDark ? 0.28 : 0.07),
                        blurRadius: _pressed ? 18 : 32,
                        offset: Offset(0, _pressed ? 10 : 18),
                      ),
                    ],
                  ),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: widget.accented ? Colors.white : null),
                    child: IconTheme.merge(
                      data: IconThemeData(color: widget.accented ? Colors.white : null),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
