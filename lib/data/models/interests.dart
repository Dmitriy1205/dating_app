class Interests {
  bool? politics;
  bool? fashion;
  bool? finArt;
  bool? music;
  bool? dance;
  bool? film;
  bool? photography;
  bool? acting;

  Interests({
    this.politics = false,
    this.fashion = false,
    this.finArt = false,
    this.music = false,
    this.dance = false,
    this.film = false,
    this.photography = false,
    this.acting = false,
  });

  Map<String, dynamic> toMap() => {
        'politics': politics,
        'fashion': fashion,
        'finArt': finArt,
        'music': music,
        'dance': dance,
        'film': film,
        'photography': photography,
        'acting': acting,
      };
}
