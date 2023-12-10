
import 'dart:io';
import 'package:proyecto_c2/features/post/domain/entities/comment/comment_entity.dart';
import 'package:proyecto_c2/features/post/domain/entities/posts/post_entity.dart';
import 'package:proyecto_c2/features/post/domain/entities/replay/replay_entity.dart';
import 'package:proyecto_c2/features/post/domain/repository/post_firebase_repository.dart';
import 'package:proyecto_c2/features/post/data/data_sources/remote_data_source/post_remote_data_source.dart';

abstract class PostFirebaseRepositoryImpl implements PostFirebaseRepository{
  final PostFirebaseRemoteDataSource remoteDataSource;

  PostFirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createPost(PostEntity post) async => remoteDataSource.createPost(post);
  @override
  Future<void> deletePost(PostEntity post) async => remoteDataSource.deletePost(post);

  @override
  Future<void> likePost(PostEntity post) async => remoteDataSource.likePost(post);

  @override
  Stream<List<PostEntity>> readPosts(PostEntity post) => remoteDataSource.readPosts(post);

  @override
  Future<void> updatePost(PostEntity post) async => remoteDataSource.updatePost(post);

  @override
  Future<void> createComment(CommentEntity comment) async => remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async => remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async => remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String postId) => remoteDataSource.readComments(postId);

  @override
  Future<void> updateComment(CommentEntity comment) async => remoteDataSource.updateComment(comment);

  @override
  Stream<List<PostEntity>> readSinglePost(String postId) => remoteDataSource.readSinglePost(postId);

  @override
  Future<void> createReplay(ReplayEntity replay) async => remoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity replay) async => remoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity replay) async => remoteDataSource.likeReplay(replay);

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) => remoteDataSource.readReplays(replay);

  @override
  Future<void> updateReplay(ReplayEntity replay) async => remoteDataSource.updateReplay(replay);

 /* @override
  Future<void> followUnFollowUser(UserEntity user) async => remoteDataSource.followUnFollowUser(user);*/

}