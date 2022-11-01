import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/facebook_auth/facebook_auth_cubit.dart';
import 'package:dating_app/ui/bloc/google_auth/google_auth_cubit.dart';
import 'package:dating_app/ui/bloc/profile/profile_cubit.dart';
import 'package:dating_app/ui/bloc/search_preferences_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/data_provider/storage_data_provider.dart';
import '../data/repositories/storage_repository.dart';
import '../ui/bloc/apple_auth/apple_auth_cubit.dart';
import '../ui/bloc/image_picker/image_picker_cubit.dart';
import '../ui/bloc/otp_verification/otp_cubit.dart';
import '../ui/bloc/profile_info_cubit/profile_info_cubit.dart';

final sl = GetIt.instance;

Future<void> boot() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  //Data Providers
  sl.registerLazySingleton(() => FirebaseDataProvider(firestore: firestore));
  sl.registerLazySingleton(() => StorageDataProvider(storage: storage));

  //Repositories
  sl.registerLazySingleton(() => DataRepository(dataProvider: sl()));
  sl.registerLazySingleton(() => StorageRepository(storageProvider: sl()));
  sl.registerLazySingleton(() => AuthRepository(
        auth: auth,
        db: sl(),
      ));

  //Cubits
  sl.registerFactory(() => GoogleAuthCubit(sl()));
  sl.registerFactory(() => ProfileCubit(auth: sl(), db: sl(), storage: sl()));
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
}

Future<void> init() async {}
