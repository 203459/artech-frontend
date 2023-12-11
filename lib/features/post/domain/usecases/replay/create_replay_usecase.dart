
import 'package:proyecto_c2/features/post/domain/entities/replay/replay_entity.dart';
import 'package:proyecto_c2/features/post/domain/repository/post_firebase_repository.dart';

class CreateReplayUseCase {
  final PostFirebaseRepository repository;

  CreateReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.createReplay(replay);
  }
}