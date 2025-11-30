import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_data.dart';
import '../repositories/game_repository.dart';

class LoadGame {
  final GameRepository repository;

  LoadGame(this.repository);

  Future<Either<Failure, GameData>> call() async {
    return await repository.loadGame();
  }
}
