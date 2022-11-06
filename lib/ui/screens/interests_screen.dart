import 'package:dating_app/core/themes/checkboxes.dart';
import 'package:flutter/material.dart';

import '../../core/constants.dart';
import '../../data/models/interests.dart';

class InterestsScreen extends StatefulWidget {
  final Map<String, dynamic>? interests;

  const InterestsScreen({Key? key, this.interests}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // Map<String, dynamic> interests = Interests().toMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 10, 0),
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
                                    'Interesets',
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
                                  //TODO: submit all data and back
                                  Navigator.pop(context, widget.interests);
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.teal,
                                    content: Text(
                                      'Success',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: SizedBox(
                                  height: 25,
                                  width: 65,
                                  child: Image.asset('assets/icons/done.png'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.interests!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          return Stack(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.interests!.update(
                                          widget.interests!.keys.elementAt(i),
                                          (value) => !value);
                                    });
                                  },
                                  child: SizedBox(
                                    width: 170,
                                    height: 168,
                                    child:
                                        Image.asset(Content.interestsList[i]),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 16,
                                child: Text(
                                  widget.interests!.keys.elementAt(i),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      backgroundColor: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                  right: 17,
                                  top: 14,
                                  child: widget.interests!.values.elementAt(i)
                                      ? CustomCheckbox.checked()
                                      : CustomCheckbox.unChecked()),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
