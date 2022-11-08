part of 'image_picker_cubit.dart';

class ImagePickerState extends Equatable {
  final Status? status;
  final List<String>? image;

  const ImagePickerState({
    this.status,
    this.image,
  });

  @override
  List<Object?> get props => [
        status,
        image,
      ];

  ImagePickerState copyWith({
    Status? status,
    List<String>? image,
  }) {
    return ImagePickerState(
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }
}
