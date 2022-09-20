import 'package:dating_app/ui/screens/reflow_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/welcome.png',
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReflowScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: const Alignment(0.1, 2.1),
                        colors: [
                          Colors.orange.withOpacity(0.8),
                          Colors.purple.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    width: 350,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'CREATE ACCOUNT',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  //TODO: navigation to Login screen
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  fixedSize: const Size(350, 50),
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'SIGN IN',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
