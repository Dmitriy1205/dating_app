part of 'search_cubit.dart';

class SearchState extends Equatable {
  final Status? status;
  final bool isSearching;

  const SearchState({
    this.status,
    this.isSearching = false,
  });

  SearchState copyWith({
    Status? status,
    bool? isSearching,
  }) {
    return SearchState(
      status: status ?? this.status,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isSearching,
      ];
}
