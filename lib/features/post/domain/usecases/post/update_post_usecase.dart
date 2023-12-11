import 'package:proyecto_c2/features/post/domain/entities/posts/post_entity.dart';
import 'package:proyecto_c2/features/post/domain/repository/post_firebase_repository.dart';

class UpdatePostUseCase {
  final PostFirebaseRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.updatePost(post);
  }
}