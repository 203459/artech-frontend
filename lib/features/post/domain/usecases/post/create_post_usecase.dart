
import 'package:proyecto_c2/features/post/domain/entities/posts/post_entity.dart';
import 'package:proyecto_c2/features/post/domain/repository/post_firebase_repository.dart';

class CreatePostUseCase {
  final PostFirebaseRepository repository;

  CreatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}