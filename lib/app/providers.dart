import 'package:dating_app/ui/bloc/connection/connection_cubit.dart';
import 'package:dating_app/ui/bloc/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/cache_helper.dart';
import '../core/services/service_locator.dart';
import '../ui/bloc/auth/auth_cubit.dart';
import '../ui/bloc/filter/filter_cubit.dart';
import '../ui/bloc/home/home_cubit.dart';
import '../ui/bloc/image_picker/image_picker_cubit.dart';
import '../ui/bloc/localization/localization_cubit.dart';
import '../ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import '../ui/bloc/register_call/register_call_cubit.dart';
import '../ui/bloc/sign_in/sign_in_cubit.dart';
import '../ui/bloc/sign_up/sign_up_cubit.dart';
import '../ui/bloc/stories/stories_cubit.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => sl<ProfileInfoCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ImagePickerCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<LocalizationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SignUpCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<SignInCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ConnectivityCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<NotificationCubit>(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => sl<StoriesCubit>(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => sl<RegisterCallCubit>()
            // ..updateFcmToken(uId: CacheHelper.getString(key: 'uId'))
            ..listenToInComingCalls(),
        ),
        BlocProvider(
          create: (context) => sl<FilterCubit>(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>(),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
