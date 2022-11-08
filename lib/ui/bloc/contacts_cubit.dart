import 'package:bloc/bloc.dart';
import 'package:dating_app/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

import '../../core/service_locator.dart';
import '../../data/repositories/data_repository.dart';

class ContactsCubit extends Cubit<ContactsCubitStates> {
  ContactsCubit() : super(ContactsEmptyListState()) {
    updateConnections();
  }

  DataRepository db = sl();
  late final List<UserModel> usersList;

  Future<void> updateConnections() async {
    usersList = await db.getPals();
    for (int i = 0; i < usersList.length; i++) {
      print('${usersList[i].firstName}');
      if (usersList[i].firstName == null) {
        print('delete ${usersList[i].firstName}');
        usersList.removeAt(i);
      }
    }
    emit(ContactsCubitInitState(usersList: usersList));
  }
}

class ContactsCubitStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactsEmptyListState extends ContactsCubitStates {}

class ContactsCubitInitState extends ContactsCubitStates {
  final List<UserModel> usersList;

  ContactsCubitInitState({required this.usersList}) {}

  @override
  List<Object?> get props {
    return [usersList];
  }
}
