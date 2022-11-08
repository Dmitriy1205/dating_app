import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/contacts_cubit.dart';
import 'package:dating_app/ui/bloc/facebook_auth/facebook_auth_cubit.dart';
import 'package:dating_app/ui/bloc/google_auth/google_auth_cubit.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/screens/messenger_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/data_provider/storage_data_provider.dart';
import '../data/models/user_model.dart';
import '../data/repositories/storage_repository.dart';
import '../ui/bloc/apple_auth/apple_auth_cubit.dart';
import '../ui/bloc/otp_verification/otp_cubit.dart';
import '../ui/bloc/profile_info_cubit/profile_info_cubit.dart';

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
  sl.registerLazySingleton(() => StorageRepository(storageProvider: sl()));
  sl.registerLazySingleton(() => AuthRepository(auth: auth, db: sl()));

  //Cubits
  sl.registerFactory(() => GoogleAuthCubit(sl()));
  sl.registerFactory(
      () => ProfileInfoCubit(db: sl(), auth: sl(), storage: sl()));
  sl.registerFactory(() => AppleAuthCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => FacebookAuthCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => ContactsCubit());
  sl.registerFactory(() => MessengerCubit(sl(), auth, userModel));
}

Future<void> init() async {}
