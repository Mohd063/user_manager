import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_me/data/model/post_model.dart';
import 'package:manage_me/data/repositories/api/post_api_repo.dart';
import 'package:manage_me/data/repositories/local/post_local_repo.dart';
import 'package:manage_me/logic/post/post_event.dart';
import 'package:manage_me/logic/post/post_state.dart';

/// Bloc responsible for managing Posts from API and Local database.
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostApiRepo postApi = PostApiRepo();
  final PostLocalRepo postLocal = PostLocalRepo();

  PostBloc() : super(PostInitial()) {
    // Register event handlers
    on<LoadApiPosts>(_onLoadApiPosts);
    on<LoadLocalPosts>(_onLoadLocalPosts);
    on<AddLocalPost>(_onAddLocalPost);
    on<ClearPosts>(_onClearPosts);
  }

  /// Handles loading posts from remote API by userId.
  /// Emits loading state, fetches data, then emits loaded or error state.
  Future<void> _onLoadApiPosts(LoadApiPosts event, Emitter<PostState> emit) async {
    final currentState = state;

    // If posts already loaded, emit loading with current data
    if (currentState is PostLoaded) {
      emit(currentState.copyWith(isApiLoading: true));
    } else {
      emit(PostLoaded(localPosts: [], apiPosts: [], isApiLoading: true));
    }

    try {
      // Fetch posts from API
      final fetchedApiPosts = await postApi.fetchPostsByUser(event.userId);

      // Update state with fetched API posts, turn off loading
      final updatedState = (state is PostLoaded)
          ? (state as PostLoaded).copyWith(apiPosts: fetchedApiPosts, isApiLoading: false)
          : PostLoaded(apiPosts: fetchedApiPosts, localPosts: [], isApiLoading: false);

      emit(updatedState);
    } catch (e) {
      // Emit error state on failure
      emit(PostError(message: e.toString()));
    }
  }

  /// Handles loading posts from local storage by userId.
  /// Emits loading state, fetches data, then emits loaded or error state.
  Future<void> _onLoadLocalPosts(LoadLocalPosts event, Emitter<PostState> emit) async {
    final currentState = state;

    // If posts already loaded, emit loading with current data
    if (currentState is PostLoaded) {
      emit(currentState.copyWith(isLocalLoading: true));
    } else {
      emit(PostLoaded(localPosts: [], apiPosts: [], isLocalLoading: true));
    }

    try {
      // Fetch posts from local storage
      final fetchedLocalPosts = await postLocal.fetchPostsByUser(event.userId);
      print("Fetched local posts count: ${fetchedLocalPosts.length}");

      // Update state with fetched local posts, turn off loading
      final updatedState = (state is PostLoaded)
          ? (state as PostLoaded).copyWith(localPosts: fetchedLocalPosts, isLocalLoading: false)
          : PostLoaded(localPosts: fetchedLocalPosts, apiPosts: [], isLocalLoading: false);

      emit(updatedState);
    } catch (e) {
      // Emit error state on failure
      emit(PostError(message: e.toString()));
    }
  }

  /// Handles adding a new post locally, then reloads the local posts.
  Future<void> _onAddLocalPost(AddLocalPost event, Emitter<PostState> emit) async {
    try {
      // Insert new post into local storage
      await postLocal.insertPost(event.post);

      // After insertion, reload all local posts for this user
      final updatedLocalPosts = await postLocal.fetchPostsByUser(event.post.userId);

      // Emit updated PostLoaded state with new local posts list
      emit(PostLoaded(
        apiPosts: state is PostLoaded ? (state as PostLoaded).apiPosts : [],
        localPosts: updatedLocalPosts,
        isApiLoading: state is PostLoaded ? (state as PostLoaded).isApiLoading : false,
        isLocalLoading: false,
      ));
    } catch (e) {
      // Emit error state on failure
      emit(PostError(message: e.toString()));
    }
  }

  /// Clears all post-related state and resets to initial.
  Future<void> _onClearPosts(ClearPosts event, Emitter<PostState> emit) async {
    emit(PostInitial());
  }
}
