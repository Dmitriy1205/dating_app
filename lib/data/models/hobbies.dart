class Hobbies {
  bool? workingout;
  bool? hiking;
  bool? biking;
  bool? shopping;
  bool? cooking;
  bool? baking;
  bool? drinking;
  bool? reading;

  Hobbies({
    this.workingout,
    this.hiking = false,
    this.biking = false,
    this.shopping = false,
    this.cooking = false,
    this.baking = false,
    this.drinking = false,
    this.reading = false,
  });

  Map<String, dynamic> toMap() => {
        'workingout': workingout,
        'hiking': hiking,
        'biking': biking,
        'shopping': shopping,
        'cooking': cooking,
        'baking': baking,
        'drinking': drinking,
        'reading': reading,
      };
}
