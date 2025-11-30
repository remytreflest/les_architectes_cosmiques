import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_data.dart';

abstract class GameRepository {
  Future<Either<Failure, GameData>> loadGame();
  Future<Either<Failure, void>> saveGame(GameData gameData);
  Future<Either<Failure, bool>> hasExistingGame();
  Future<Either<Failure, List<String>>> fetchPlanetNames();
  Future<Either<Failure, GameData>> createNewGame(
    String playerName,
    List<String> planetNames,
  );
}
