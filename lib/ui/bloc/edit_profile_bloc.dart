import 'package:bloc/bloc.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:equatable/equatable.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
  ReUsableWidgets reUsableWidgets = ReUsableWidgets();
  List<String> selectedLookingForList = [];

  Future<void> changeData(String selectedLookingFor) async {
    selectedLookingForList.contains(selectedLookingFor)
        ? selectedLookingForList.remove(selectedLookingFor)
        : selectedLookingForList.add(selectedLookingFor);
    print('lookingFor from EditProfileCubit ${selectedLookingForList}');

    emit(ChangeEditProfileState(selectedLookingForList));
  }
}




abstract class EditProfileState extends Equatable {}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class ChangeEditProfileState extends EditProfileState {
  late List<String> selectedLookingForList;

  ChangeEditProfileState(List<String> selectedLookingForList);

  @override
  List<Object?> get props => [double.nan];
}
