import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 10, 0),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      splashRadius: 0.1,
                                      iconSize: 28,
                                      alignment: Alignment.topLeft,
                                      icon: const Icon(
                                        Icons.close,
                                      ),
                                    ),
                                    const Text(
                                      'Interests',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      //TODO: submit all data and navigate to home page
                                    },
                                    child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                            'assets/icons/check.png'))),
                                // const Icon(
                                //   Icons.check,
                                // ),
                              ],
                            ),
                            //TODO: make clickable item list of interests
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
