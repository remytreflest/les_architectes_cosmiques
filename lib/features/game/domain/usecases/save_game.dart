import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_data.dart';
import '../repositories/game_repository.dart';

class SaveGame {
  final GameRepository repository;

  SaveGame(this.repository);

  Future<Either<Failure, void>> call(GameData gameData) async {
    return await repository.saveGame(gameData);
  }
}
