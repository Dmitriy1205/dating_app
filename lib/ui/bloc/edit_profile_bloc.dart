import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class EditProfileCubit extends Cubit<EditProfileState>{
  EditProfileCubit() : super(EditProfileInitial());


}


abstract class EditProfileState extends Equatable {}

class EditProfileInitial extends EditProfileState {
  @override
  List<Object?> get props => [];
}