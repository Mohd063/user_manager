import 'package:equatable/equatable.dart';
import 'package:manage_me/data/model/post_model.dart';

/// Base class for all post-related events.
abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to load posts from API for a specific user.
class LoadApiPosts extends PostEvent {
  final int userId;

  LoadApiPosts({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// Event to load posts stored locally for a specific user.
class LoadLocalPosts extends PostEvent {
  final int userId;

  LoadLocalPosts({required this.userId});

  @override
  List<Object> get props => [userId];
}

/// Event to add a new post to local storage.
class AddLocalPost extends PostEvent {
  final PostModel post;

  AddLocalPost({required this.post});

  @override
  List<Object> get props => [post];
}

/// Event to clear all posts (both local and API).
class ClearPosts extends PostEvent {}
