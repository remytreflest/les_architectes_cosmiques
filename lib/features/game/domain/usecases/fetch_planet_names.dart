import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/game_repository.dart';

class FetchPlanetNames {
  final GameRepository repository;

  FetchPlanetNames(this.repository);

  Future<Either<Failure, List<String>>> call() async {
    return await repository.fetchPlanetNames();
  }
}
