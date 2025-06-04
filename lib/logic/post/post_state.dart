import 'package:equatable/equatable.dart';
import 'package:manage_me/data/model/post_model.dart';

/// Base abstract class for Post states.
/// Extends Equatable to allow value comparison and avoid unnecessary rebuilds.
abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// 🟡 Initial State: Represents the state before any posts are loaded.
class PostInitial extends PostState {}

/// ✅ Loaded State: Contains the combined data from API and local sources.
/// Also tracks loading status for API and local data separately.
class PostLoaded extends PostState {
  final List<PostModel> apiPosts;      // Posts fetched from the API
  final List<PostModel> localPosts;    // Posts fetched from local storage/database
  final bool isApiLoading;              // Whether API posts are currently loading
  final bool isLocalLoading;            // Whether local posts are currently loading

  PostLoaded({
    required this.apiPosts,
    required this.localPosts,
    this.isApiLoading = false,
    this.isLocalLoading = false,
  });

  /// Creates a copy of the current PostLoaded state with optional new values.
  /// Useful for partial state updates without overwriting unchanged fields.
  PostLoaded copyWith({
    List<PostModel>? apiPosts,
    List<PostModel>? localPosts,
    bool? isApiLoading,
    bool? isLocalLoading,
  }) {
    return PostLoaded(
      apiPosts: apiPosts ?? this.apiPosts,
      localPosts: localPosts ?? this.localPosts,
      isApiLoading: isApiLoading ?? this.isApiLoading,
      isLocalLoading: isLocalLoading ?? this.isLocalLoading,
    );
  }

  @override
  List<Object> get props => [apiPosts, localPosts, isApiLoading, isLocalLoading];
}

/// 🔴 Error State: Represents an error that occurred while loading posts.
class PostError extends PostState {
  final String message;  // Error message describing what went wrong

  PostError({required this.message});

  @override
  List<Object> get props => [message];
}
