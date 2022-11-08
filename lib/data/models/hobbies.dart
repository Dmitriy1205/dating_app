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
    this.workingout = false,
    this.hiking = false,
    this.biking = false,
    this.shopping = false,
    this.cooking = false,
    this.baking = false,
    this.drinking = false,
    this.reading = false,
  });

  Map<String, dynamic> toMap() => {
        'WorkingOut': workingout,
        'Hiking': hiking,
        'Biking': biking,
        'Shopping': shopping,
        'Cooking': cooking,
        'Baking': baking,
        'Drinking': drinking,
        'Reading': reading,
      };
}
