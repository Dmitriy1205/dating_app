import 'package:dating_app/ui/screens/sing_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReflowScreen extends StatelessWidget {
  const ReflowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/comm.png',
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    splashRadius: 0.1,
                    iconSize: 28,
                    alignment: Alignment.topLeft,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Make your Myness account in minutes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Gain free access to the Myness interface'
                    ' and start meeting people today',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: buildTextColumn(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
                          'LET\'S GO',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTextColumn() {
  return Column(
    children: [
      const SizedBox(
        height: 35,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '●  ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              'Find people who are looking for same things you are',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '●  ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              'Create a profile which outlines who you are, socially and professionally',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '●  ',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              'Form meaningful relationships and expand your network',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
          children: [
            const TextSpan(
                text: 'By tapping "Let\'s go", you have an accepted our '),
            TextSpan(
                text: 'Terms and Conditions',
                style: TextStyle(
                  color: Colors.pinkAccent[200],
                  fontSize: 12,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //TODO: implement terms and condition screen
                  }),
          ],
        ),
      ),
    ],
  );
}
