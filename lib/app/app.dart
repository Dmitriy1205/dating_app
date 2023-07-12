import 'package:dating_app/app/providers.dart';
import 'package:dating_app/l10n/l10n.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/notification/notification_cubit.dart';
import 'package:dating_app/ui/screens/home_screen.dart';
import 'package:dating_app/ui/screens/profile_info_screen.dart';
import 'package:dating_app/ui/screens/search_pref_screen.dart';
import 'package:dating_app/ui/screens/welcome_screen.dart';
import 'package:dating_app/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../core/routes.dart';
import '../core/themes/colors.dart';
import '../core/utils/navigation_key.dart';
import '../ui/bloc/connection/connection_cubit.dart';
import '../ui/bloc/localization/localization_cubit.dart';
import '../ui/widgets/connection_message.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Providers(
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              localizationsDelegates: L10n.localizationsDelegates,
              supportedLocales: L10n.locales,
              locale: state.locale,
              theme: ThemeData(
                chipTheme: chipTheme(),
                sliderTheme: CustomColors.customGradient(),
                unselectedWidgetColor: Colors.orange,
                expansionTileTheme: const ExpansionTileThemeData(
                  textColor: Colors.orangeAccent,
                  iconColor: Colors.orangeAccent,
                ),
              ),
              routes: routes,
              debugShowCheckedModeBanner: false,
              title: 'Dating App',
              home: BlocListener<ConnectivityCubit, ConnectivityState>(
                listener: (context, state) {
                  if (state.status == ConnectivityStatus.lostConnectivity) {
                    ConnectionMessage.buildDisconnectedSnackbar(context);
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is Authorized) {
                      context.read<LocalizationCubit>().init();
                      context
                          .read<NotificationCubit>()
                          .saveToken(currentUserId: state.user!.uid);
                      if (state.userModel?.profileInfo == null) {
                        DateFormat format = DateFormat('MMMM d, y');
                        DateTime birthdayDate = format.parse(state.userModel!.birthday!);

                        DateTime now = DateTime.now();
                        int age = now.year - birthdayDate.year;
                        return ProfileInfoScreen(
                            name: state.userModel!.firstName!,
                            date: age.toString());
                      } else if (state.userModel?.searchPref == null) {
                        return const SearchPrefScreen();
                      } else {
                        return const HomeScreen();
                      }
                    } else if (state is Loading) {
                      return const Material(child: LoadingIndicator());
                    } else {
                      return const WelcomeScreen();
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
//
// Widget _buildHomeScreen() {
//   return StreamBuilder<User?>(
//     stream: FirebaseAuth.instance.authStateChanges(),
//     builder: (context, snapshot) {
//
//     },
//   );
// }
}
