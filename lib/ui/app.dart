import 'package:dating_app/ui/bloc/auth/auth_cubit.dart';
import 'package:dating_app/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/service_locator.dart';
import '../core/themes/colors.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(sliderTheme: CustomColors.CustomGradient(),
            unselectedWidgetColor: Colors.orange,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Dating App',
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}
