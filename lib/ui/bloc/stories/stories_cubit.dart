import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/status.dart';
import '../../../data/models/story.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/data_repository.dart';
import '../../../data/repositories/storieas_repository.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final StoriesRepository _storiesRepository;
  final AuthRepository _authRepository;
  final DataRepository _dataRepository;

  StoriesCubit({
    required StoriesRepository storiesRepository,
    required AuthRepository authRepository,
    required DataRepository dataRepository,
  })  : _storiesRepository = storiesRepository,
        _authRepository = authRepository,
        _dataRepository = dataRepository,
        super(StoriesState(status: Status.initial()));

  Future<void> fetchAllStories() async {
    emit(state.copyWith(status: Status.loading()));
    try {
      final String currentUserId = _authRepository.currentUser()!.uid;
      final List<Stories>? currentUserStories =
          await _storiesRepository.getCurrentUserStories(userId: currentUserId);

      List<Story> usersStories = await _storiesRepository.getAllUsersStories();
      List<UserModel> addedUsersList =
          await _dataRepository.getContacts(currentUserId: currentUserId);

      usersStories.removeWhere((story) =>
          story.id == currentUserId ||
          !addedUsersList.any((user) => user.id == story.id));

      for (var user in addedUsersList) {
        List<String> userMatch =
            await _dataRepository.isUserMatch(user.id.toString());
        if (!userMatch.contains(currentUserId) || userMatch.contains(null)) {
          usersStories.removeWhere((story) => story.id == user.id);
        }
      }

      emit(state.copyWith(
        status: Status.loaded(),
        currentUserStories: currentUserStories,
        usersStory: usersStories,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }

  Future<void> publish({required Uint8List image}) async {
    emit(state.copyWith(status: Status.loading()));
    try {
      final String currentUserId = _authRepository.currentUser()!.uid;
      await _storiesRepository.publishStory(
        file: image,
        currentUserId: currentUserId,
      );
      fetchAllStories();
      emit(state.copyWith(status: Status.loaded()));
    } on Exception catch (e) {
      emit(state.copyWith(status: Status.error(e.toString())));
    }
  }
}
