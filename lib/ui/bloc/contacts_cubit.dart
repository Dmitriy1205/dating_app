import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../core/service_locator.dart';
import '../../data/models/status.dart';
import '../../data/repositories/data_repository.dart';

class ContactsCubit extends Cubit<ContactsCubitStates> {
  ContactsCubit({required this.authRepository})
      : super(ContactsCubitStates(status: Status.initial())) {
    updateConnections();
  }

  late UserModel palUser;
  DataRepository db = sl();
  final AuthRepository authRepository;
  List<UserModel> usersList = [];
  List<String> imagesList = [];

  Future<String> getUrlImage(String id) async {
    final String image = await db.getUserFields(id).then((value) {
      return value!.profileInfo!.image! ??
          'https://firebasestorage.googleapis.com/v0/b/dating-app-95830.appspot.com/o/users%2F7kyZ3iSjKUQyQHNTNpB1gzU8pP33%2Fimage2.png?alt=media&token=968c17f4-46ee-4e0b-a3e7-b6d0a92c3f4c';
    });
    return image;
  }

  Future<void> updateConnections() async {
    usersList = await db.getContacts();
    final u = await db.getUserFields(authRepository.currentUser()!.uid);
    for (int i = 0; i < usersList.length; i++) {
      print('${usersList[i].firstName}');
      if (usersList[i].id == authRepository.currentUser()!.uid) {
        print('delete ${usersList[i].firstName}');
        usersList.removeAt(i);
      }
      imagesList.add(await getUrlImage(usersList[i].id!));
    }
    emit(state.copyWith(
      usersList: usersList,
      status: Status.loaded(),
      image: imagesList,
      currentUserAvatar: u!.profileInfo?.image,
      currentUserId: u.id,
      currentUserName: u.firstName,
    ));
  }
}

class ContactsCubitStates extends Equatable {
  final List<String>? image;
  final List<UserModel>? usersList;
  final Status? status;
  final String? currentUserId;
  final String? currentUserName;
  final String? currentUserAvatar;

  const ContactsCubitStates({
    this.image,
    this.usersList,
    this.status,
    this.currentUserAvatar,
    this.currentUserId,
    this.currentUserName,
  });

  @override
  List<Object?> get props => [
        image,
        usersList,
        status,
        currentUserAvatar,
        currentUserId,
        currentUserName,
      ];

  ContactsCubitStates copyWith({
    List<String>? image,
    List<UserModel>? usersList,
    Status? status,
    String? currentUserAvatar,
    String? currentUserId,
    String? currentUserName,
  }) {
    return ContactsCubitStates(
      image: image ?? this.image,
      usersList: usersList ?? this.usersList,
      status: status ?? this.status,
      currentUserAvatar: currentUserAvatar ?? this.currentUserAvatar,
      currentUserId: currentUserId ?? this.currentUserId,
      currentUserName: currentUserName ?? this.currentUserName,
    );
  }
}
