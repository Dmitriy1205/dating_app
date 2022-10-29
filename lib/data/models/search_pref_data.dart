class SearchPrefData {
  Map<String, int>? yearsRange;
  int? distance;
  Map<String, dynamic>? lookingFor;
  String? gender;

  Map<String, dynamic> toMap() => {
        'yearsRange': yearsRange,
        'distance': distance,
        'lookingFor': lookingFor,
        'gender': gender,
      };
}
