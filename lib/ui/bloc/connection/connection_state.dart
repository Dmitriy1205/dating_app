part of 'connection_cubit.dart';

enum ConnectivityStatus { initial, active, lostConnectivity }

class ConnectivityState extends Equatable {
  final ConnectivityStatus? status;

  const ConnectivityState({this.status});

  ConnectivityState copyWith({
    ConnectivityStatus? status,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
