import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/core/services/cache_helper.dart';
import 'package:dating_app/core/services/dio_helper.dart';
import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:dating_app/data/repositories/user_repository.dart';
import 'package:dating_app/data/repositories/video_call_repository.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/contacts_cubit.dart';
import 'package:dating_app/ui/bloc/facebook_auth/facebook_auth_cubit.dart';
import 'package:dating_app/ui/bloc/filter/filter_cubit.dart';
import 'package:dating_app/ui/bloc/google_auth/google_auth_cubit.dart';
import 'package:dating_app/ui/bloc/personal_profile_cubit/personal_profile_cubit.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/bloc/register_call/register_call_cubit.dart';
import 'package:dating_app/ui/bloc/settings/settings_cubit.dart';
import 'package:dating_app/ui/bloc/profile/profile_cubit.dart';
import 'package:dating_app/ui/bloc/search_preferences_bloc.dart';
import 'package:dating_app/ui/bloc/video_call/video_call_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import '../data/data_provider/storage_data_provider.dart';
import '../data/models/user_model.dart';
import '../data/repositories/storage_repository.dart';
import '../ui/bloc/apple_auth/apple_auth_cubit.dart';
import '../ui/bloc/edit_profile_bloc.dart';
import '../ui/bloc/home/home_cubit.dart';
import '../ui/bloc/image_picker/image_picker_cubit.dart';
import '../ui/bloc/localization/localization_cubit.dart';
import '../ui/bloc/otp_verification/otp_cubit.dart';
import '../ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'notifications.dart';

final sl = GetIt.instance;
UserModel userModel = UserModel();


get user => userModel;

Future<void> boot() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  //Data Providers
  sl.registerLazySingleton(() => FirebaseDataProvider(firestore: firestore));
  sl.registerLazySingleton(() => StorageDataProvider(storage: storage));

  //Repositories
  sl.registerLazySingleton(() => DataRepository(dataProvider: sl()));
  sl.registerLazySingleton(() => VideoCallRepository(firestore: firestore));
  sl.registerLazySingleton(() => StorageRepository(storageProvider: sl()));
  sl.registerLazySingleton(() => AuthRepository(auth: auth, db: sl()));
  sl.registerLazySingleton(
      () => UserRepository(firestore: firestore, auth: auth));

  //Cubits
  sl.registerFactory(() => GoogleAuthCubit(sl()));
  sl.registerFactory(() => VideoCallCubit(repo: sl()));
  sl.registerFactory(() => RegisterCallCubit(repo: sl()));
  sl.registerLazySingleton(() => LocalizationCubit(auth: sl(), db: sl()));
  sl.registerLazySingleton(() => SettingsCubit(sl()));
  sl.registerFactory(() => PersonalProfileCubit(sl()));
  sl.registerFactory(() => HomeCubit(db: sl(), auth: sl()));
  sl.registerLazySingleton(() => FilterCubit(db: sl(), auth: sl()));
  sl.registerFactory(() => ProfileCubit(auth: sl(), db: sl(), storage: sl()));
  sl.registerFactory(
      () => EditProfileCubit(auth: sl(), db: sl(), storage: sl()));
  sl.registerFactory(() => SearchPreferencesCubit(
        db: sl(),
        auth: sl(),
      ));
  sl.registerFactory(() => ImagePickerCubit(
        storage: sl(),
        auth: sl(),
      ));
  sl.registerFactory(() => ProfileInfoCubit(
        db: sl(),
        auth: sl(),
        storage: sl(),
      ));
  sl.registerFactory(() => AppleAuthCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => FacebookAuthCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => ContactsCubit(authRepository: sl()));
  sl.registerFactory(() => MessengerCubit(sl(), auth, userModel));
}

Future<void> init() async {
Notifications.initialize(Notifications.flutterLocalNotificationsPlugin);
  DioHelper.init();
  await CacheHelper.init();
}
