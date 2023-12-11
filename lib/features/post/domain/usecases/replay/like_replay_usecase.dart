import 'package:proyecto_c2/features/post/domain/entities/replay/replay_entity.dart';
import 'package:proyecto_c2/features/post/domain/repository/post_firebase_repository.dart';

class LikeReplayUseCase {
  final PostFirebaseRepository repository;

  LikeReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.likeReplay(replay);
  }
}