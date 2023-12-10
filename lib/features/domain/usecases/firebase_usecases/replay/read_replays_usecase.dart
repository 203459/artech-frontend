import 'package:proyecto_c2/features/domain/entities/replay/replay_entity.dart';
import 'package:proyecto_c2/features/domain/repository/firebase_repository.dart';

class ReadReplaysUseCase {
  final FirebaseRepository repository;

  ReadReplaysUseCase({required this.repository});

  Stream<List<ReplayEntity>> call(ReplayEntity replay) {
    return repository.readReplays(replay);
  }
}