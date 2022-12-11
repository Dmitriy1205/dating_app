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
        'Politics': politics,
        'Fashion': fashion,
        'FinArt': finArt,
        'Music': music,
        'Dance': dance,
        'Film': film,
        'Photography': photography,
        'Acting': acting,
      };
}
