import 'package:flutter/material.dart';

import 'planet_icon.dart';
import 'planet_info.dart';
import 'pulsing_badge.dart';

class PlanetCard extends StatefulWidget {
  final dynamic planet;
  final bool isActive;
  final bool isSelected;
  final int astrophysicsLevel;
  final bool canColonizeMore;
  final Animation<double> animation;
  final VoidCallback? onTap;
  final VoidCallback? onColonize;

  const PlanetCard({
    Key? key,
    required this.planet,
    required this.isActive,
    required this.isSelected,
    required this.astrophysicsLevel,
    required this.canColonizeMore,
    required this.animation,
    this.onTap,
    this.onColonize,
  }) : super(key: key);

  @override
  State<PlanetCard> createState() => _PlanetCardState();
}

class _PlanetCardState extends State<PlanetCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: widget.animation, curve: Curves.easeInOut),
    );

    final hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    return AnimatedBuilder(
      animation: Listenable.merge([pulseAnimation, hoverAnimation]),
      builder: (context, child) {
        final scale = widget.isSelected
            ? pulseAnimation.value
            : 1.0 + (hoverAnimation.value * 0.02);

        return Transform.scale(
          scale: scale,
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovered = true);
              _hoverController.forward();
            },
            onExit: (_) {
              setState(() => _isHovered = false);
              _hoverController.reverse();
            },
            child: _buildCard(),
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    final isColonized = widget.planet.isColonized;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: widget.isActive && isColonized
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ]
            : _isHovered
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Card(
        elevation: _isHovered ? 8 : 2,
        color: widget.isActive && isColonized
            ? Colors.blue.withOpacity(0.2)
            : isColonized
            ? null
            : Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: widget.isActive && isColonized
              ? const BorderSide(color: Colors.blue, width: 2)
              : BorderSide.none,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: PlanetIcon(
            isColonized: isColonized,
            isActive: widget.isActive,
          ),
          title: _buildTitle(),
          subtitle: PlanetInfo(
            planet: widget.planet,
            astrophysicsLevel: widget.astrophysicsLevel,
            canColonizeMore: widget.canColonizeMore,
          ),
          trailing: _buildTrailing(),
          onTap: widget.onTap,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    final isColonized = widget.planet.isColonized;
    final showBadge =
        !isColonized && widget.astrophysicsLevel > 0 && widget.canColonizeMore;

    return Row(
      children: [
        Text(
          widget.planet.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isColonized ? Colors.white : Colors.grey,
          ),
        ),
        if (showBadge) ...[
          const SizedBox(width: 8),
          const PulsingBadge(text: 'Disponible'),
        ],
      ],
    );
  }

  Widget _buildTrailing() {
    final isColonized = widget.planet.isColonized;

    if (widget.isActive && isColonized) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 28);
    }

    if (isColonized) {
      return const Icon(Icons.arrow_forward_ios, color: Colors.white54);
    }

    if (!isColonized &&
        widget.astrophysicsLevel > 0 &&
        widget.canColonizeMore) {
      return IconButton(
        icon: const Icon(Icons.add_location_alt, color: Colors.green, size: 28),
        onPressed: widget.onColonize,
        tooltip: 'Coloniser',
      );
    }

    return const Icon(Icons.lock, color: Colors.grey);
  }
}
