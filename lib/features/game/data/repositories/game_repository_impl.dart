import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/game_data.dart';
import '../../domain/entities/planet.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/local_storage_datasource.dart';
import '../datasources/solar_system_remote_datasource.dart';
import '../models/game_data_model.dart';

class GameRepositoryImpl implements GameRepository {
  final LocalStorageDataSource localDataSource;
  final SolarSystemRemoteDataSource remoteDataSource;

  GameRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GameData>> loadGame() async {
    try {
      final gameData = await localDataSource.loadGame();
      return Right(gameData);
    } catch (e) {
      return Left(StorageFailure('Failed to load game: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveGame(GameData gameData) async {
    try {
      final gameDataModel = GameDataModel.fromEntity(gameData);
      await localDataSource.saveGame(gameDataModel);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to save game: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasExistingGame() async {
    try {
      final hasGame = await localDataSource.hasGame();
      return Right(hasGame);
    } catch (e) {
      return Left(
        StorageFailure('Failed to check existing game: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchPlanetNames() async {
    try {
      final planetNames = await remoteDataSource.fetchPlanetNames();
      return Right(planetNames);
    } catch (e) {
      return Left(
        NetworkFailure('Failed to fetch planet names: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, GameData>> createNewGame(
    String playerName,
    List<String> planetNames,
  ) async {
    try {
      final planets = <Planet>[];
      for (int i = 0; i < planetNames.length && i < 8; i++) {
        planets.add(
          Planet(
            id: (i + 1).toString(),
            name: planetNames[i],
            isColonized: i == 0,
            metal: i == 0 ? 1000 : 0,
            crystal: i == 0 ? 500 : 0,
            deuterium: i == 0 ? 100 : 0,
          ),
        );
      }

      final gameData = GameData(
        playerName: playerName,
        planets: planets,
        activePlanetId: '1',
      );

      await saveGame(gameData);
      return Right(gameData);
    } catch (e) {
      return Left(StorageFailure('Failed to create new game: ${e.toString()}'));
    }
  }
}
