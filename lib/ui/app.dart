import 'package:dating_app/ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        theme: ThemeData(
          unselectedWidgetColor: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Dating App',
        home: WelcomeScreen(),
      ),
    );
  }
}
