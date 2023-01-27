part of 'blocked_contacts_cubit.dart';

class BlockedContactsState extends Equatable {
  final Status? status;
  final List<UserModel>? usersList;

  const BlockedContactsState({
    this.status,
    this.usersList,
  });

  BlockedContactsState copyWith({
    final Status? status,
    final List<UserModel>? usersList,
  }) {
    return BlockedContactsState(
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
