import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/storage_repository.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit({required this.auth, required this.storage})
      : super(ImagePickerState(status: Status.initial())) {
    getAllImages();
  }

  final AuthRepository auth;
  final StorageRepository storage;

  void switcher(int pick) => emit(state.copyWith(pick: pick));

  Future<void> uploadImage(Uint8List source) async {
    emit(state.copyWith(status: Status.loading()));
    try {

      var id = auth.currentUser()!.uid;
      await storage.upload(source, 'users/$id/image${idGenerator()}.png');
      emit(state.copyWith(status: Status.loaded()));
    } catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<String?> uploadMessageImage(Uint8List source, String chatId) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      String imageUrl =
          await storage.upload(source, 'chats/$chatId/${DateTime.now()}');
      emit(state.copyWith(status: Status.loaded()));
      return imageUrl;
    } catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
    return null;
  }

  Future<void> getAllImages() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      var id = auth.currentUser()!.uid;
      var image = await storage.getAllById(id);
      emit(state.copyWith(status: Status.loaded(), image: image));
    } catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
  String idGenerator() {
    final Random random = Random.secure();

    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const int charsLength = chars.length;

    String id = '';

    for (int i = 0; i < 8; i++) {
      id += chars[random.nextInt(charsLength)];
    }

    return id;
  }
}
