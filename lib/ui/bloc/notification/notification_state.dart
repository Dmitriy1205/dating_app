part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final Status? status;

  const NotificationState({this.status});

  NotificationState copyWith({
    final Status? status,
  }) {
    return NotificationState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
