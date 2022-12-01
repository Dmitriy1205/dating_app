import 'package:dating_app/l10n/l10n.dart';
import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/bloc/profile_info_cubit/profile_info_cubit.dart';
import 'package:dating_app/ui/screens/home_screen.dart';
import 'package:dating_app/ui/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/routes.dart';
import '../core/service_locator.dart';
import '../core/themes/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<ProfileInfoCubit>(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.locales,
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
          home: _buildHomeScreen(),
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}
