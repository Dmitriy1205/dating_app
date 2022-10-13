import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/facebook_auth/facebook_auth_cubit.dart';
import 'package:dating_app/ui/bloc/google_auth/google_auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> boot() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => AuthRepository(auth: auth));

  sl.registerFactory(() => GoogleAuthCubit(sl()));
  sl.registerFactory(() => FacebookAuthCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
}

Future<void> init() async {}
