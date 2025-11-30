import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_data.dart';
import '../repositories/game_repository.dart';

class CreateNewGame {
  final GameRepository repository;

  CreateNewGame(this.repository);

  Future<Either<Failure, GameData>> call(
    String playerName,
    List<String> planetNames,
  ) async {
    return await repository.createNewGame(playerName, planetNames);
  }
}
