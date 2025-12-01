import 'package:flutter/material.dart';

class PulsingBadge extends StatefulWidget {
  final String text;
  final Color color;
  final Color backgroundColor;

  const PulsingBadge({
    Key? key,
    required this.text,
    this.color = Colors.green,
    Color? backgroundColor,
  }) : backgroundColor = backgroundColor ?? Colors.green,
       super(key: key);

  @override
  State<PulsingBadge> createState() => _PulsingBadgeState();
}

class _PulsingBadgeState extends State<PulsingBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final opacity = 0.7 + (_pulseController.value * 0.3);
        return Opacity(
          opacity: opacity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: widget.backgroundColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: widget.color, width: 1),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
