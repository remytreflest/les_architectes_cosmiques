class GameConstants {
  static const String storageKey = 'game_data_v2';
  static const String solarSystemApiUrl =
      'https://api.le-systeme-solaire.net/rest/bodies/';
  static const String apiKey = '1234-4567-8912-1234';

  static const Map<String, String> planetTranslations = {
    'Mercury': 'Mercure',
    'Venus': 'Vénus',
    'Earth': 'Terre',
    'Mars': 'Mars',
    'Jupiter': 'Jupiter',
    'Saturn': 'Saturne',
    'Uranus': 'Uranus',
    'Neptune': 'Neptune',
  };

  static const List<String> orderedPlanets = [
    'Mercury',
    'Venus',
    'Earth',
    'Mars',
    'Jupiter',
    'Saturn',
    'Uranus',
    'Neptune',
  ];

  static const List<String> fallbackPlanetNames = [
    'Mercure fallback',
    'Vénus fallback',
    'Terre fallback',
    'Mars fallback',
    'Jupiter fallback',
    'Saturne fallback',
    'Uranus fallback',
    'Neptune fallback',
  ];
}
