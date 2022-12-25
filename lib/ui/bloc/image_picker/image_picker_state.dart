part of 'image_picker_cubit.dart';

class ImagePickerState extends Equatable {
  final Status? status;
  final List<String>? image;
  final int? pick;

  const ImagePickerState({
    this.status,
    this.image,
    this.pick,
  });

  @override
  List<Object?> get props => [
        status,
        image,
        pick,
      ];

  ImagePickerState copyWith({
    Status? status,
    List<String>? image,
    int? pick,
  }) {
    return ImagePickerState(
      status: status ?? this.status,
      image: image ?? this.image,
      pick: pick ?? this.pick,
    );
  }
}
