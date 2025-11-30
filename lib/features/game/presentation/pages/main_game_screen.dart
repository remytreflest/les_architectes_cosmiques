import 'package:flutter/material.dart';

import '../../domain/entities/planet.dart';
import '../controllers/game_controller.dart';
import '../widgets/resource_bar.dart';
import 'buildings_page.dart';
import 'dashboard_page.dart';
import 'gyroscope_page.dart';
import 'technologies_page.dart';

class MainGameScreen extends StatefulWidget {
  final GameController controller;

  const MainGameScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onGameDataChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onGameDataChanged);
    super.dispose();
  }

  void _onGameDataChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Planet? getActivePlanetSafe() {
    final gameData = widget.controller.gameData;
    if (gameData == null) return null;

    try {
      return gameData.planets.firstWhere(
        (p) => p.id == gameData.activePlanetId,
      );
    } catch (e) {
      return gameData.planets.isNotEmpty ? gameData.planets.first : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameData = widget.controller.gameData;
    if (gameData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentPlanet = getActivePlanetSafe();

    final pages = [
      DashboardPage(
        controller: widget.controller,
        onPlanetChange: (planetId) {
          final planet = gameData.planets.firstWhere((p) => p.id == planetId);
          if (planet.isColonized) {
            setState(() {
              gameData.activePlanetId = planetId;
              widget.controller.saveGameData();
            });
          }
        },
      ),
      currentPlanet != null && currentPlanet.isColonized
          ? BuildingsPage(
              planet: currentPlanet,
              onBuild: (buildingId) {
                setState(() {
                  currentPlanet.buildings[buildingId] =
                      (currentPlanet.buildings[buildingId] ?? 0) + 1;
                  widget.controller.saveGameData();
                });
              },
            )
          : const _LockedPage(),
      currentPlanet != null && currentPlanet.isColonized
          ? TechnologiesPage(
              gameData: gameData,
              planet: currentPlanet,
              isDiplomacy: false,
              onResearch: (techId) {
                setState(() {
                  gameData.technologies[techId] =
                      (gameData.technologies[techId] ?? 0) + 1;
                  widget.controller.saveGameData();
                });
              },
            )
          : const _LockedPage(),
      currentPlanet != null && currentPlanet.isColonized
          ? TechnologiesPage(
              gameData: gameData,
              planet: currentPlanet,
              isDiplomacy: true,
              onResearch: (techId) {
                setState(() {
                  gameData.diplomacyTechs[techId] =
                      (gameData.diplomacyTechs[techId] ?? 0) + 1;
                  widget.controller.saveGameData();
                });
              },
            )
          : const _LockedPage(),
      currentPlanet != null && currentPlanet.isColonized
          ? GyroscopePage(
              planet: currentPlanet,
              onReward: () => widget.controller.saveGameData(),
            )
          : const _LockedPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Commandant ${gameData.playerName}'),
        bottom: currentPlanet != null && currentPlanet.isColonized
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: ResourceBar(planet: currentPlanet),
              )
            : null,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Bâtiments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Technologies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Politiques',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Bonus'),
        ],
      ),
    );
  }
}

class _LockedPage extends StatelessWidget {
  const _LockedPage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Colonisez d\'abord cette planète',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
