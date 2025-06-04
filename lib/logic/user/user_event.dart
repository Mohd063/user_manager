abstract class UserEvent {}

class FetchUsers extends UserEvent {
  final bool isInitialFetch;

  FetchUsers({this.isInitialFetch = false});
}

class FetchUserDetails extends UserEvent {
  final int userId;

  FetchUserDetails(this.userId);
}
