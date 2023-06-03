part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {}

class Initial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authorized extends AuthState {
  final User? user;

  Authorized({this.user});

  @override
  List<Object?> get props => [user];
}

class Unauthorized extends AuthState {
  @override
  List<Object?> get props => [];
}
