class PhotoCard {
  final String title;
  final String location;
  final String description;
  final String imagePath;
  final bool isLocalImage;
  final String cardId;

  PhotoCard({
    this.title = "",
    this.location = '',
    this.description = "",
    this.imagePath = "",
    this.isLocalImage = true,
    required this.cardId,
  });
}
