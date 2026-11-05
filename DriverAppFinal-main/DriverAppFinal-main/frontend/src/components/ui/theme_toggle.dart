import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const ThemeToggle({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      tooltip: isDark ? 'Mudar para tema claro' : 'Mudar para tema escuro',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        child: Icon(
          isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          key: ValueKey<bool>(isDark),
          color: isDark ? Colors.amber : Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
    );
  }
}