import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.deepOrangeAccent,
                  )),
              const Text(
                'Terms & conditions',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox()
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Text(
                style: TextStyle(height: 1.4),
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
                'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '
                'enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor '
                'in reprehenderit in voluptate velit esse cillum dolore eu fugiat'
                ' nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
