part of 'friends_list_cubit.dart';

class FriendsListState extends Equatable {
  final Status? status;
  final List<UserModel>? usersList;

  const FriendsListState({
    this.status,
    this.usersList,
  });

  FriendsListState copyWith({
    final Status? status,
    final List<UserModel>? usersList,
  }) {
    return FriendsListState(
      status: status ?? this.status,
      usersList: usersList ?? this.usersList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        usersList,
      ];
}
