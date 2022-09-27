import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.deepOrangeAccent,
                  )),
              Expanded(
                child: Column(children: const [
                  SafeArea(child: Text('Terms & Conditions',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
                          'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '
                          'enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                          'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor '
                          'in reprehenderit in voluptate velit esse cillum dolore eu fugiat'
                          ' nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
                          ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

