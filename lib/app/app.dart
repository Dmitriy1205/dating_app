import 'package:dating_app/app/providers.dart';
import 'package:dating_app/l10n/l10n.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/notification/notification_cubit.dart';
import 'package:dating_app/ui/screens/home_screen.dart';
import 'package:dating_app/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/routes.dart';
import '../core/themes/colors.dart';
import '../core/utils/navigation_key.dart';
import '../ui/bloc/localization/localization_cubit.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);



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
              home: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is Authorized) {
                    context.read<LocalizationCubit>().init();
                    context
                        .read<NotificationCubit>()
                        .saveToken(currentUserId: state.user!.uid);
                    return const HomeScreen();
                  } else {
                    return const WelcomeScreen();
                  }
                },
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
