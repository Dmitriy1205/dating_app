import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connection_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  late final StreamSubscription _connectivitySubscription;

  ConnectivityCubit({required InternetConnectionChecker connectionChecker})
      : super(const ConnectivityState(status: ConnectivityStatus.initial)) {
    _connectivitySubscription =
        connectionChecker.onStatusChange.listen((connectivity) async {
      if (connectivity == InternetConnectionStatus.connected) {
        emit(state.copyWith(status: ConnectivityStatus.active));
      } else {
        emit(state.copyWith(status: ConnectivityStatus.lostConnectivity));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
