import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/core/services/cache_helper.dart';
import 'package:dating_app/core/services/dio_helper.dart';
import 'package:dating_app/data/data_provider/firestore_data_provider.dart';
import 'package:dating_app/data/repositories/auth_repository.dart';
import 'package:dating_app/data/repositories/data_repository.dart';
import 'package:dating_app/data/repositories/storieas_repository.dart';
import 'package:dating_app/data/repositories/user_repository.dart';
import 'package:dating_app/data/repositories/video_call_repository.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/contacts_cubit.dart';
import 'package:dating_app/ui/bloc/facebook_auth/facebook_auth_cubit.dart';
import 'package:dating_app/ui/bloc/filter/filter_cubit.dart';
import 'package:dating_app/ui/bloc/friends_list/friends_list_cubit.dart';
import 'package:dating_app/ui/bloc/google_auth/google_auth_cubit.dart';
import 'package:dating_app/ui/bloc/notification/notification_cubit.dart';
import 'package:dating_app/ui/bloc/personal_profile_cubit/personal_profile_cubit.dart';
import 'package:dating_app/ui/bloc/messenger_cubit.dart';
import 'package:dating_app/ui/bloc/register_call/register_call_cubit.dart';
import 'package:dating_app/ui/bloc/settings/settings_cubit.dart';
import 'package:dating_app/ui/bloc/profile/profile_cubit.dart';
import 'package:dating_app/ui/bloc/search_preferences_bloc.dart';
import 'package:dating_app/ui/bloc/stories/stories_cubit.dart';
import 'package:dating_app/ui/bloc/video_call/video_call_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import '../../data/data_provider/storage_data_provider.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/storage_repository.dart';
import '../../ui/bloc/apple_auth/apple_auth_cubit.dart';
import '../../ui/bloc/blocked_contacts/blocked_contacts_cubit.dart';
import '../../ui/bloc/edit_profile_bloc.dart';
import '../../ui/bloc/home/home_cubit.dart';
import '../../ui/bloc/image_picker/image_picker_cubit.dart';
import '../../ui/bloc/localization/localization_cubit.dart';
import '../../ui/bloc/otp_verification/otp_cubit.dart';
import '../../ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import '../../ui/bloc/search/search_cubit.dart';
import '../../ui/bloc/sign_in/sign_in_cubit.dart';
import '../../ui/bloc/sign_up/sign_up_cubit.dart';
import 'fcm_service.dart';

final sl = GetIt.instance;
UserModel userModel = UserModel();

get user => userModel;

Future<void> boot() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //services
  sl.registerLazySingleton(() => FCMService(messaging: messaging));

  //Data Providers
  sl.registerLazySingleton(() => FirebaseDataProvider(firestore: firestore));
  sl.registerLazySingleton(() => StorageDataProvider(storage: storage));

  //Repositories
  sl.registerLazySingleton(() => DataRepository(dataProvider: sl()));
  sl.registerLazySingleton(() => VideoCallRepository(firestore: firestore));
  sl.registerLazySingleton(() => StorageRepository(storageProvider: sl()));
  sl.registerLazySingleton(() => AuthRepository(auth: auth, db: sl()));
  sl.registerLazySingleton(
      () => UserRepository(firestore: firestore, auth: auth, firebaseDataProvider: sl()));
  sl.registerLazySingleton(() => NotificationRepository(messaging: sl()));
  sl.registerLazySingleton(()=> StoriesRepository(storage: sl(), firestore: sl()));

  //Cubits
  sl.registerFactory(() => GoogleAuthCubit(sl()));
  sl.registerFactory(() => SearchCubit());
  sl.registerFactory(() => FriendsListCubit(auth: sl(), db: sl()));
  sl.registerFactory(() => BlockedContactsCubit(auth: sl(), db: sl()));
  sl.registerFactory(() => VideoCallCubit(repo: sl()));
  sl.registerFactory(() => RegisterCallCubit(repo: sl()));
  sl.registerFactory(() => LocalizationCubit(auth: sl(), db: sl()));
  sl.registerFactory(() => SettingsCubit(sl()));
  sl.registerFactory(() => PersonalProfileCubit(sl()));
  sl.registerLazySingleton(() => HomeCubit(db: sl(), auth: sl()));
  sl.registerFactory(() => FilterCubit(db: sl(), auth: sl()));
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
  sl.registerLazySingleton(() => AuthCubit(sl()));
  sl.registerFactory(() => ContactsCubit(authRepository: sl(), userRepository: sl(), dataRepository: sl()));
  sl.registerFactory(() => SignUpCubit(authRepository: sl()));
  sl.registerFactory(() => SignInCubit(authRepository: sl()));
  sl.registerFactory(() => MessengerCubit(sl(), auth, userModel));
  sl.registerLazySingleton(() => NotificationCubit(
      notificationRepo: sl(), firestoreRepo: sl(), authRepository: sl()));
  sl.registerFactory(() => StoriesCubit(storiesRepository: sl(), authRepository: sl(), dataRepository: sl()));
}

Future<void> init() async {
  await sl<FCMService>().initializeFirebase();
  await sl<FCMService>().initializeLocalNotifications();
  await sl<FCMService>().onMessage();
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
  DioHelper.init();
  await CacheHelper.init();
}

@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
