import 'package:flutter/material.dart';

import '../../features/game/data/models/onboarding_slide_model.dart';

class OnboardingSlidesData {
  static List<OnboardingSlide> getSlides() {
    return [
      OnboardingSlide(
        icon: '🚀',
        title: 'Bienvenue, Commandant !',
        description:
            'Préparez-vous à conquérir le système solaire et à bâtir votre empire galactique.',
        color: Colors.deepPurple,
      ),
      OnboardingSlide(
        icon: '🪐',
        title: 'Colonisez les Planètes',
        description: 'Explorez et colonisez les 8 planètes du système solaire.',
        features: [
          '🌍 Gestion Multi-Planètes',
          '⚡ Production Automatique',
          '📊 Ressources en temps réel',
        ],
        color: Colors.blue,
      ),
      OnboardingSlide(
        icon: '🏭',
        title: 'Construisez des Bâtiments',
        description:
            'Développez votre infrastructure pour produire des ressources.',
        features: [
          '⛏️ Mines (Métal, Cristal, Deutérium)',
          '☀️ Centrale Solaire (Énergie)',
          '🤖 Usine de Robots (Construction)',
        ],
        color: Colors.orange,
      ),
      OnboardingSlide(
        icon: '🔬',
        title: 'Recherchez des Technologies',
        description: 'Débloquez 9 technologies pour améliorer votre empire.',
        features: [
          '🔫 Laser, Plasma, Hyperespace',
          '📈 Améliorations progressives',
          '🚀 Nouvelles capacités',
        ],
        color: Colors.cyan,
      ),
      OnboardingSlide(
        icon: '🎭',
        title: 'Adoptez des Politiques',
        description:
            'Choisissez parmi 8 politiques galactiques humoristiques !',
        features: [
          '☭ Communisme Spatial',
          '💰 Capitalisme Galactique',
          '🥖 Révolution Française',
          '🍕 Pizza Party Universelle',
        ],
        color: Colors.pink,
      ),
      OnboardingSlide(
        icon: '📱',
        title: 'Secouez pour Gagner !',
        description:
            'Utilisez le gyroscope de votre téléphone pour obtenir des ressources bonus.',
        features: ['✨ Bonus surprises', '🎮 Mini-jeu interactif'],
        color: Colors.amber,
        isShaking: true,
      ),
      OnboardingSlide(
        icon: '🎮',
        title: 'Prêt à Conquérir ?',
        description: 'Votre aventure commence maintenant !',
        features: [
          '💾 Sauvegarde Automatique',
          '⏱️ Production en Temps Réel',
          '🌌 Univers Immersif',
        ],
        color: Colors.deepPurple,
        isLast: true,
      ),
    ];
  }
}
