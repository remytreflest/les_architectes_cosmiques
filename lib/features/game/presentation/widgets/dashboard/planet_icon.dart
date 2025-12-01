import 'package:flutter/material.dart';

class PlanetIcon extends StatefulWidget {
  final bool isColonized;
  final bool isActive;

  const PlanetIcon({
    Key? key,
    required this.isColonized,
    required this.isActive,
  }) : super(key: key);

  @override
  State<PlanetIcon> createState() => _PlanetIconState();
}

class _PlanetIconState extends State<PlanetIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * 3.14159,
          child: Icon(
            Icons.public,
            size: 40,
            color: widget.isColonized ? Colors.blue : Colors.grey,
          ),
        );
      },
    );
  }
}
