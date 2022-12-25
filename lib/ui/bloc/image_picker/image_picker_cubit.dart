import 'dart:io';

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

  Future<void> uploadImage(File source, String name) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      var id = auth.currentUser()!.uid;
      await storage.upload(source, 'users/$id/image$name.png');
      emit(state.copyWith(status: Status.loaded()));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<String?> uploadMessageImage(File source, String chatId) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      String imageUrl =
          await storage.upload(source, 'chats/$chatId/${DateTime.now()}');
      emit(state.copyWith(status: Status.loaded()));
      return imageUrl;
    } catch (e) {
      print(e);
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> getAllImages() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      var id = auth.currentUser()!.uid;
      var image = await storage.getAllById(id);
      emit(state.copyWith(status: Status.loaded(), image: image));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
