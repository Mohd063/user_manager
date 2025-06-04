import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_me/data/model/user_model.dart';
import 'package:manage_me/data/repositories/user_repository.dart';
import 'package:manage_me/logic/user/user_event.dart';
import 'package:manage_me/logic/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  int currentPage = 1;
  final int limit = 20;
  bool isFetching = false;
  bool hasReachedMax = false;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<FetchUserDetails>(_onFetchUserDetails);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (isFetching || hasReachedMax) return;
    isFetching = true;

    try {
      // Reset if it's initial fetch
      if (event.isInitialFetch) {
        currentPage = 1;
        hasReachedMax = false;
        emit(UserLoading());
      }

      List<UserModel> currentUsers = [];

      if (state is UserLoaded && !event.isInitialFetch) {
        currentUsers = (state as UserLoaded).users;
      }

      final newUsers = await userRepository.getUsersFromApi(
        page: currentPage,
        limit: limit,
      );

      final allUsers = [...currentUsers, ...newUsers];

      hasReachedMax = newUsers.length < limit;

      emit(UserLoaded(
        allUsers,
        hasReachedMax: hasReachedMax,
      ));

      if (!hasReachedMax) currentPage++;
    } catch (_) {
      emit(UserError("Failed to load users"));
    }

    isFetching = false;
  }

  Future<void> _onFetchUserDetails(
      FetchUserDetails event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.getUserDetails(event.userId);
      if (user != null) {
        emit(UserDetailLoaded(user));
      } else {
        emit(UserError("User not found"));
      }
    } catch (_) {
      emit(UserError("Failed to load user details"));
    }
  }
}
