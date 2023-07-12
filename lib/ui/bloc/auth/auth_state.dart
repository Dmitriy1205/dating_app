part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {}

class Initial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authorized extends AuthState {
  final User? user;
  final UserModel? userModel;

  Authorized( {this.user, this.userModel,});

  @override
  List<Object?> get props => [user,userModel];
}
class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}
class Unauthorized extends AuthState {
  @override
  List<Object?> get props => [];
}
