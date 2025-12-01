import 'package:flutter/material.dart';

class ColonizationInfoCard extends StatelessWidget {
  final int astrophysicsLevel;

  const ColonizationInfoCard({Key? key, required this.astrophysicsLevel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: 0.9 + (0.1 * value), child: child),
        );
      },
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 10),
          Card(
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
                        : 'Développez la technologie Astrophysique pour '
                              'coloniser de nouvelles planètes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
