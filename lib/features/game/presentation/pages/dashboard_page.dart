import 'package:flutter/material.dart';

import '../controllers/game_controller.dart';
import '../widgets/dashboard/astrophysics_banner.dart';
import '../widgets/dashboard/colonization_info_card.dart';
import '../widgets/dashboard/colonize_dialog.dart';
import '../widgets/dashboard/planet_card.dart';

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
    setState(() => _selectedPlanetId = planetId);

    _animationController.forward(from: 0.0).then((_) {
      widget.onPlanetChange(planetId);
    });
  }

  Future<void> _showColonizeDialog(String planetId, String planetName) async {
    final error = await showDialog<String?>(
      context: context,
      builder: (context) => ColonizeDialog(
        controller: widget.controller,
        planetId: planetId,
        planetName: planetName,
      ),
    );

    if (!mounted) return;

    if (error == null) {
      // Succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$planetName colonisée avec succès !'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (error.isNotEmpty) {
      // Erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    }
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
        _buildAnimatedHeader(),

        const SizedBox(height: 10),

        // Bannière Astrophysique
        if (astrophysicsLevel > 0) ...[
          AstrophysicsBanner(
            level: astrophysicsLevel,
            colonizedCount: colonizedCount,
            maxPlanets: maxPlanets,
            canColonizeMore: canColonizeMore,
          ),
          const SizedBox(height: 12),
        ],

        const Text(
          'Sélectionnez votre planète active',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),

        // Liste des planètes
        ...gameData.planets.asMap().entries.map((entry) {
          final index = entry.key;
          final planet = entry.value;
          final isActive = planet.id == gameData.activePlanetId;
          final isSelected = planet.id == _selectedPlanetId;

          return _buildAnimatedPlanetCard(
            planet: planet,
            index: index,
            isActive: isActive,
            isSelected: isSelected,
            astrophysicsLevel: astrophysicsLevel,
            canColonizeMore: canColonizeMore,
          );
        }),

        const SizedBox(height: 20),

        // Info colonisation
        if (gameData.planets.where((p) => !p.isColonized).isNotEmpty)
          ColonizationInfoCard(astrophysicsLevel: astrophysicsLevel),
      ],
    );
  }

  Widget _buildAnimatedHeader() {
    return TweenAnimationBuilder<double>(
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
    );
  }

  Widget _buildAnimatedPlanetCard({
    required dynamic planet,
    required int index,
    required bool isActive,
    required bool isSelected,
    required int astrophysicsLevel,
    required bool canColonizeMore,
  }) {
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
      child: PlanetCard(
        planet: planet,
        isActive: isActive,
        isSelected: isSelected,
        astrophysicsLevel: astrophysicsLevel,
        canColonizeMore: canColonizeMore,
        animation: _animationController,
        onTap: planet.isColonized
            ? () => _handlePlanetChange(planet.id)
            : astrophysicsLevel > 0 && canColonizeMore
            ? () => _showColonizeDialog(planet.id, planet.name)
            : null,
        onColonize: astrophysicsLevel > 0 && canColonizeMore
            ? () => _showColonizeDialog(planet.id, planet.name)
            : null,
      ),
    );
  }
}
