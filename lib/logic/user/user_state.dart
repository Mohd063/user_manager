import 'package:manage_me/data/model/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final bool hasReachedMax;

  UserLoaded(this.users, {this.hasReachedMax = false});
}

class UserDetailLoaded extends UserState {
  final UserModel user;
  UserDetailLoaded(this.user);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
