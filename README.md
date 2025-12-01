# 🚀 Space Empire - Jeu spatial type OGame

Un jeu de stratégie spatiale inspiré d'OGame, développé en Flutter avec une architecture Clean.

## 📱 Fonctionnalités

### 🌍 Système solaire complet
- 8 planètes du système solaire (noms récupérés via API)
- Colonisation progressive des planètes
- Gestion multi-planètes

### 🏗️ Bâtiments
- **Mine de Métal** - Produit du métal
- **Mine de Cristal** - Produit du cristal
- **Synthétiseur de Deutérium** - Produit du deutérium
- **Centrale Solaire** - Fournit de l'énergie
- **Usine de Robots** - Accélère la construction
- **Chantier Spatial** - Construit des vaisseaux

### ⚡ Système d'énergie
- Production d'énergie via centrales solaires
- Consommation énergétique progressive des mines
- Réduction automatique de la production si énergie insuffisante

### 🔬 Technologies
- **9 technologies classiques** (Laser, Plasma, Hyperespace, etc.)
- **8 politiques galactiques humoristiques** :
    - ☭ Communisme Spatial
    - 💰 Capitalisme Galactique
    - 🏢 Action de Trump
    - 🥖 Révolution Française
    - 🍕 Pizza Party Universelle
    - 😂 Memes Intergalactiques
    - ☕ Café Spatial Premium
    - 👽 Alliance Extraterrestre

### 🎮 Mini-jeu Gyroscope
- Secouez votre téléphone pour gagner des ressources bonus

### 💾 Sauvegarde
- Sauvegarde automatique locale
- Mise à jour des ressources en temps réel (1x/seconde)

## 🏗️ Architecture

Le projet utilise une **Clean Architecture** :
```
lib/
├── core/
│   ├── constants/          # Constantes du jeu
│   ├── errors/             # Gestion d'erreurs
│   └── utils/              # Utilitaires
│
├── features/game/
│   ├── domain/             # Logique métier
│   │   ├── entities/       # Planète, GameData, etc.
│   │   ├── repositories/   # Interfaces
│   │   └── usecases/       # Actions métier
│   │
│   ├── data/               # Implémentation
│   │   ├── datasources/    # API, Storage
│   │   ├── models/         # Modèles JSON
│   │   └── repositories/   # Implémentations
│   │
│   └── presentation/       # Interface utilisateur
│       ├── controllers/    # GameController
│       ├── pages/          # Écrans
│       └── widgets/        # Composants UI
│
└── injection_container.dart  # Dependency Injection
```

### Principes appliqués
- ✅ **Séparation des responsabilités** (Domain/Data/Presentation)
- ✅ **Injection de dépendances** (GetIt)
- ✅ **Gestion d'état** (ChangeNotifier)
- ✅ **Gestion d'erreurs fonctionnelle** (Either<Failure, Success>)

## 🚀 Installation

### Prérequis
- Flutter SDK (3.0+)
- Dart SDK (3.0+)

### Dépendances
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Dependency Injection
  get_it: ^7.6.0
  
  # Functional Programming
  dartz: ^0.10.1
  
  # Storage
  shared_preferences: ^2.2.2
  
  # HTTP
  http: ^1.1.0
  
  # Sensors
  sensors_plus: ^3.1.0
```

### Commandes
```bash
# Cloner le projet
git clone <votre-repo>
cd les_architectes_cosmiques

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

```

## 🎮 Utilisation

1. **Premier lancement** : Entrez votre nom de commandant
2. **Dashboard** : Visualisez vos planètes et sélectionnez la planète active
3. **Bâtiments** : Construisez des mines et centrales
4. **Technologies** : Recherchez des technologies pour débloquer de nouvelles possibilités
5. **Politiques** : Adoptez des politiques pour des bonus permanents
6. **Bonus** : Jouez au mini-jeu gyroscope pour gagner des ressources

## 📊 Système de ressources

### Production
- Les mines produisent automatiquement des ressources
- La production est calculée toutes les secondes
- L'énergie disponible impacte la production

### Coûts
Les coûts augmentent exponentiellement :
```
Coût niveau N = Coût base × 1.5^(N-1)
```

## 🔧 Configuration

### API Système Solaire
L'application utilise l'API publique "Le Système Solaire" :
```
URL: https://api.le-systeme-solaire.net/rest/bodies/
Clé API: ****-****-****-****
```

### Stockage Local
Utilise SharedPreferences pour :
- Sauvegarde de la partie
- Ressources des planètes
- Bâtiments construits
- Technologies recherchées

## 🐛 Debug

Les logs de l'API sont visibles dans la console :
```
🌍 [DEBUG] Tentative de récupération des planètes...
✅ [DEBUG] Appel API réussi !
🌍 [DEBUG] Planètes traduites: [Mercure, Vénus, Terre, ...]
```

## 📝 TODO / Améliorations futures

- [ ] Système de vaisseaux spatiaux
- [ ] Combat entre joueurs
- [ ] Alliances
- [ ] Chat en jeu
- [ ] Classement global
- [ ] Événements temporaires
- [ ] Mode multijoueur
- [ ] Synchronisation cloud

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.


## 🙏 Remerciements

- Inspiré par [OGame](https://ogame.org)
- API du système solaire : [Le Système Solaire](https://api.le-systeme-solaire.net)
- Icônes et ressources : Flutter Material Design

---

**Bon jeu, Commandant ! 🚀**