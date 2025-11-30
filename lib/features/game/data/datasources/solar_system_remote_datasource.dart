import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/game_constants.dart';

abstract class SolarSystemRemoteDataSource {
  Future<List<String>> fetchPlanetNames();
}

class SolarSystemRemoteDataSourceImpl implements SolarSystemRemoteDataSource {
  final http.Client client;

  SolarSystemRemoteDataSourceImpl({required this.client});

  @override
  Future<List<String>> fetchPlanetNames() async {
    print('🌍 [DEBUG] Tentative de récupération des planètes depuis l\'API...');
    print('🌍 [DEBUG] URL: ${GameConstants.solarSystemApiUrl}');

    try {
      final response = await client.get(
        Uri.parse(GameConstants.solarSystemApiUrl),
        headers: {
          'Authorization': 'Bearer ${GameConstants.apiKey}',
          'Content-Type': 'application/json',
        },
      );

      print('🌍 [DEBUG] Code de réponse HTTP: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('✅ [DEBUG] Appel API réussi !');

        final data = jsonDecode(response.body);
        final bodies = data['bodies'] as List;

        print('🌍 [DEBUG] Nombre de corps célestes reçus: ${bodies.length}');

        final planets = bodies
            .where(
              (body) => body['isPlanet'] == true && body['englishName'] != null,
            )
            .map((body) => body['englishName'] as String)
            .toList();

        print('🌍 [DEBUG] Planètes identifiées: $planets');

        final orderedPlanetNames = GameConstants.orderedPlanets
            .where((name) => planets.contains(name))
            .map((name) => GameConstants.planetTranslations[name] ?? name)
            .toList();

        print('✅ [DEBUG] Planètes traduites et ordonnées: $orderedPlanetNames');

        return orderedPlanetNames;
      } else {
        print(
          '❌ [DEBUG] Échec de l\'appel API - Status: ${response.statusCode}',
        );
        print('❌ [DEBUG] Corps de la réponse: ${response.body}');
      }
    } catch (e, stackTrace) {
      print('❌ [DEBUG] Erreur lors de l\'appel API: $e');
      print('❌ [DEBUG] Stack trace: $stackTrace');
    }

    print('⚠️  [DEBUG] Utilisation des noms de planètes par défaut (fallback)');
    return GameConstants.fallbackPlanetNames;
  }
}
