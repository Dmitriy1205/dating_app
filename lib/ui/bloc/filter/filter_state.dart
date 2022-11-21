part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final Status? status;
  final RangeValues? age;
  final SearchPrefFields? searchFields;
  final int? distance;
  final String? gender;
  final Map<String, dynamic>? lookingFor;
  final Map<String, dynamic>? hobbies;
  final Map<String, dynamic>? interests;
  final List<String>? loFor;
  final List<String>? hob;
  final List<String>? inter;

  const FilterState({
    this.status,
    this.age,
    this.distance,
    this.searchFields,
    this.lookingFor,
    this.gender,
    this.loFor,
    this.hobbies,
    this.hob,
    this.interests,
    this.inter,
  });

  @override
  List<Object?> get props => [
        status,
        age,
        distance,
        searchFields,
        lookingFor,
        gender,
        loFor,
        hobbies,
        hob,
        interests,
        inter,
      ];

  FilterState copyWith({
    Status? status,
    RangeValues? age,
    SearchPrefFields? searchFields,
    int? distance,
    Map<String, dynamic>? lookingFor,
    String? gender,
    List<String>? loFor,
    Map<String, dynamic>? hobbies,
    Map<String, dynamic>? interests,
    List<String>? inter,
    List<String>? hob,
  }) {
    return FilterState(
      status: status ?? this.status,
      age: age ?? this.age,
      distance: distance ?? this.distance,
      searchFields: searchFields ?? this.searchFields,
      lookingFor: lookingFor ?? this.lookingFor,
      gender: gender ?? this.gender,
      loFor: loFor ?? this.loFor,
      hobbies: hobbies ?? this.hobbies,
      hob: hob ?? this.hob,
      interests: interests ?? this.interests,
      inter: inter ?? this.inter,
    );
  }
}
