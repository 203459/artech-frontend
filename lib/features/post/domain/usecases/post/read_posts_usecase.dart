import 'package:proyecto_c2/features/post/domain/entities/posts/post_entity.dart';
import 'package:proyecto_c2/features/post/domain/repository/post_firebase_repository.dart';

class ReadPostsUseCase {
  final PostFirebaseRepository repository;

  ReadPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}