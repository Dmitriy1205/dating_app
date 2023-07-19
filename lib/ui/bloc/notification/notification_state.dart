part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final Status? status;
  final bool? isOnline;

  const NotificationState({this.status, this.isOnline});

  NotificationState copyWith({final Status? status, final bool? isOnline}) {
    return NotificationState(
        status: status ?? this.status, isOnline: isOnline ?? this.isOnline);
  }

  @override
  List<Object?> get props => [status, isOnline];
}
