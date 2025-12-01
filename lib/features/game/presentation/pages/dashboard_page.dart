import 'package:flutter/material.dart';

import '../../../../core/utils/number_formatter.dart';
import '../../domain/usecases/colonize_planet.dart';
import '../controllers/game_controller.dart';

class DashboardPage extends StatefulWidget {
  final GameController controller;
  final Function(String) onPlanetChange;

  const DashboardPage({
    Key? key,
    required this.controller,
    required this.onPlanetChange,
  }) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String? _selectedPlanetId;

  @override
  void initState() {
    super.initState();
    _selectedPlanetId = widget.controller.gameData?.activePlanetId;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handlePlanetChange(String planetId) {
    setState(() {
      _selectedPlanetId = planetId;
    });

    _animationController.forward(from: 0.0).then((_) {
      widget.onPlanetChange(planetId);
    });
  }

  Future<void> _showColonizeDialog(
    BuildContext context,
    String planetId,
    String planetName,
  ) async {
    final gameData = widget.controller.gameData!;
    final cost = ColonizePlanet.getColonizationCost(gameData);
    final activePlanet = gameData.planets.firstWhere(
      (p) => p.id == gameData.activePlanetId,
    );

    final canAfford =
        activePlanet.metal >= cost['metal']! &&
        activePlanet.crystal >= cost['crystal']! &&
        activePlanet.deuterium >= cost['deuterium']!;

    showDialog(
      context: context,
      builder: (context) => _ColonizeDialog(
        planetName: planetName,
        cost: cost,
        activePlanet: activePlanet,
        canAfford: canAfford,
        onConfirm: () async {
          Navigator.pop(context);
          final error = await widget.controller.colonizePlanetById(planetId);

          if (context.mounted) {
            if (error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error), backgroundColor: Colors.red),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$planetName colonisée avec succès !'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameData = widget.controller.gameData!;
    final astrophysicsLevel = gameData.technologies['astrophysics'] ?? 0;
    final colonizedCount = gameData.planets.where((p) => p.isColonized).length;
    final maxPlanets = 1 + astrophysicsLevel;
    final canColonizeMore = widget.controller.canColonizeMorePlanets();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header avec animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: const Text(
            'Système Solaire',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),

        // Info Astrophysique avec animation
        if (astrophysicsLevel > 0) ...[
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.8 + (0.2 * value),
                  child: child,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.science, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Astrophysique Niveau $astrophysicsLevel',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Planètes : $colonizedCount / $maxPlanets',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (canColonizeMore)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Colonisation disponible',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Limite atteinte',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],

        const Text(
          'Sélectionnez votre planète active',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),

        // Liste des planètes avec animations échelonnées
        ...gameData.planets.asMap().entries.map((entry) {
          final index = entry.key;
          final planet = entry.value;
          final isActive = planet.id == gameData.activePlanetId;
          final isColonized = planet.isColonized;
          final isSelected = planet.id == _selectedPlanetId;

          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 400 + (index * 100)),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(50 * (1 - value), 0),
                  child: child,
                ),
              );
            },
            child: AnimatedPlanetCard(
              planet: planet,
              isActive: isActive,
              isColonized: isColonized,
              isSelected: isSelected,
              astrophysicsLevel: astrophysicsLevel,
              canColonizeMore: canColonizeMore,
              animation: _animationController,
              onTap: isColonized
                  ? () => _handlePlanetChange(planet.id)
                  : astrophysicsLevel > 0 && canColonizeMore
                  ? () => _showColonizeDialog(context, planet.id, planet.name)
                  : null,
              onColonize: astrophysicsLevel > 0 && canColonizeMore
                  ? () => _showColonizeDialog(context, planet.id, planet.name)
                  : null,
            ),
          );
        }),

        const SizedBox(height: 20),

        // Info colonisation
        if (gameData.planets.where((p) => !p.isColonized).isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 10),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.9 + (0.1 * value),
                  child: child,
                ),
              );
            },
            child: Card(
              color: Colors.orange.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      astrophysicsLevel > 0
                          ? Icons.info_outline
                          : Icons.lock_outline,
                      color: Colors.orange,
                      size: 32,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      astrophysicsLevel > 0
                          ? 'Système de colonisation'
                          : 'Planètes à coloniser',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      astrophysicsLevel > 0
                          ? 'Cliquez sur une planète disponible pour la coloniser.\n'
                                'Le coût augmente avec chaque nouvelle colonie.'
                          : 'Développez la technologie Astrophysique pour coloniser de nouvelles planètes',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ============================================================================
// Widget de carte de planète animée
// ============================================================================
class AnimatedPlanetCard extends StatefulWidget {
  final dynamic planet;
  final bool isActive;
  final bool isColonized;
  final bool isSelected;
  final int astrophysicsLevel;
  final bool canColonizeMore;
  final Animation<double> animation;
  final VoidCallback? onTap;
  final VoidCallback? onColonize;

  const AnimatedPlanetCard({
    Key? key,
    required this.planet,
    required this.isActive,
    required this.isColonized,
    required this.isSelected,
    required this.astrophysicsLevel,
    required this.canColonizeMore,
    required this.animation,
    this.onTap,
    this.onColonize,
  }) : super(key: key);

  @override
  State<AnimatedPlanetCard> createState() => _AnimatedPlanetCardState();
}

class _AnimatedPlanetCardState extends State<AnimatedPlanetCard>
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
    // Animation de pulsation pour la planète sélectionnée
    final pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: widget.animation, curve: Curves.easeInOut),
    );

    // Animation de hover
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: widget.isActive && widget.isColonized
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
                color: widget.isActive && widget.isColonized
                    ? Colors.blue.withOpacity(0.2)
                    : widget.isColonized
                    ? null
                    : Colors.grey.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: widget.isActive && widget.isColonized
                      ? const BorderSide(color: Colors.blue, width: 2)
                      : BorderSide.none,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: _AnimatedPlanetIcon(
                    isColonized: widget.isColonized,
                    isActive: widget.isActive,
                  ),
                  title: Row(
                    children: [
                      Text(
                        widget.planet.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: widget.isColonized
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                      if (!widget.isColonized &&
                          widget.astrophysicsLevel > 0 &&
                          widget.canColonizeMore) ...[
                        const SizedBox(width: 8),
                        _PulsingBadge(text: 'Disponible'),
                      ],
                    ],
                  ),
                  subtitle: widget.isColonized
                      ? _ColonizedPlanetInfo(planet: widget.planet)
                      : _UncolonizedPlanetInfo(
                          astrophysicsLevel: widget.astrophysicsLevel,
                          canColonizeMore: widget.canColonizeMore,
                        ),
                  trailing: _buildTrailing(),
                  onTap: widget.onTap,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrailing() {
    if (widget.isActive && widget.isColonized) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 28);
    }

    if (widget.isColonized) {
      return const Icon(Icons.arrow_forward_ios, color: Colors.white54);
    }

    if (!widget.isColonized &&
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

// ============================================================================
// Icône de planète animée
// ============================================================================
class _AnimatedPlanetIcon extends StatefulWidget {
  final bool isColonized;
  final bool isActive;

  const _AnimatedPlanetIcon({
    required this.isColonized,
    required this.isActive,
  });

  @override
  State<_AnimatedPlanetIcon> createState() => _AnimatedPlanetIconState();
}

class _AnimatedPlanetIconState extends State<_AnimatedPlanetIcon>
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

// ============================================================================
// Badge pulsant
// ============================================================================
class _PulsingBadge extends StatefulWidget {
  final String text;

  const _PulsingBadge({required this.text});

  @override
  State<_PulsingBadge> createState() => _PulsingBadgeState();
}

class _PulsingBadgeState extends State<_PulsingBadge>
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
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.green,
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

// ============================================================================
// Info planète colonisée
// ============================================================================
class _ColonizedPlanetInfo extends StatelessWidget {
  final dynamic planet;

  const _ColonizedPlanetInfo({required this.planet});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'M: ${NumberFormatter.format(planet.metal)} | C: ${NumberFormatter.format(planet.crystal)} | D: ${NumberFormatter.format(planet.deuterium)}',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        if (planet.metalProduction > 0 ||
            planet.crystalProduction > 0 ||
            planet.deuteriumProduction > 0)
          Text(
            'Prod: +${planet.metalProduction.toStringAsFixed(1)}/s M | +${planet.crystalProduction.toStringAsFixed(1)}/s C',
            style: const TextStyle(color: Colors.green, fontSize: 11),
          )
        else
          const Text(
            'Aucune production (construisez des mines)',
            style: TextStyle(color: Colors.orange, fontSize: 11),
          ),
        Row(
          children: [
            const Icon(Icons.bolt, size: 12, color: Colors.yellow),
            const SizedBox(width: 4),
            Text(
              '${planet.energyProduction.toInt()}/${planet.energyConsumption.toInt()}',
              style: TextStyle(
                color: planet.getAvailableEnergy() >= 0
                    ? Colors.yellow
                    : Colors.red,
                fontSize: 11,
              ),
            ),
            if (planet.getEnergyRatio() < 1.0) ...[
              const SizedBox(width: 8),
              Text(
                '(${(planet.getEnergyRatio() * 100).toInt()}% efficacité)',
                style: const TextStyle(color: Colors.orange, fontSize: 11),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// Info planète non colonisée
// ============================================================================
class _UncolonizedPlanetInfo extends StatelessWidget {
  final int astrophysicsLevel;
  final bool canColonizeMore;

  const _UncolonizedPlanetInfo({
    required this.astrophysicsLevel,
    required this.canColonizeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Non colonisée', style: TextStyle(color: Colors.grey)),
        if (astrophysicsLevel == 0)
          const Text(
            'Recherchez Astrophysique pour coloniser',
            style: TextStyle(color: Colors.orange, fontSize: 10),
          )
        else if (!canColonizeMore)
          const Text(
            'Améliorez Astrophysique pour plus de colonies',
            style: TextStyle(color: Colors.orange, fontSize: 10),
          ),
      ],
    );
  }
}

// ============================================================================
// Dialog de colonisation (inchangé)
// ============================================================================
class _ColonizeDialog extends StatelessWidget {
  final String planetName;
  final Map<String, int> cost;
  final dynamic activePlanet;
  final bool canAfford;
  final VoidCallback onConfirm;

  const _ColonizeDialog({
    required this.planetName,
    required this.cost,
    required this.activePlanet,
    required this.canAfford,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Coloniser $planetName ?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coût de colonisation :',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _CostRow(
            'Métal',
            cost['metal']!,
            activePlanet.metal,
            Icons.currency_bitcoin,
            Colors.grey,
          ),
          _CostRow(
            'Cristal',
            cost['crystal']!,
            activePlanet.crystal,
            Icons.diamond,
            Colors.cyan,
          ),
          _CostRow(
            'Deutérium',
            cost['deuterium']!,
            activePlanet.deuterium,
            Icons.water_drop,
            Colors.green,
          ),
          if (!canAfford) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ressources insuffisantes',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Text(
            'Ressources de départ :',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 4),
          const Text(
            '• 500 Métal\n• 300 Cristal\n• 100 Deutérium',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: canAfford ? onConfirm : null,
          child: const Text('Coloniser'),
        ),
      ],
    );
  }
}

class _CostRow extends StatelessWidget {
  final String resource;
  final int cost;
  final double available;
  final IconData icon;
  final Color color;

  const _CostRow(
    this.resource,
    this.cost,
    this.available,
    this.icon,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    final canAfford = available >= cost;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$resource: ${NumberFormatter.formatInt(cost)}',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            '(${NumberFormatter.format(available)})',
            style: TextStyle(
              fontSize: 12,
              color: canAfford ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
