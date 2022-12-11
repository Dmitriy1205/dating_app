part of 'localization_cubit.dart';

class LocalizationState extends Equatable {
  final Locale locale;

  const LocalizationState({required this.locale});

  LocalizationState copyWith({
    Locale? locale,
  }) {
    return LocalizationState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [locale];
}
