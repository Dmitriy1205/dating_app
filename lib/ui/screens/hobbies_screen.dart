import 'package:dating_app/core/constants.dart';
import 'package:flutter/material.dart';

class HobbiesScreen extends StatefulWidget {
  const HobbiesScreen({Key? key}) : super(key: key);

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
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
                                    'Hobbies',
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
                                  Navigator.pop(context);
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
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                                'How do you like to spend your free time?'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Content.hobbiesList.length,
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
                                      _checks[i] = !_checks[i];
                                    });
                                  },
                                  child: SizedBox(
                                    width: 170,
                                    height: 168,
                                    child: Image.asset(Content.hobbiesList[i]),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                bottom: 16,
                                child: Text(
                                  name[i],
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
                                child: !_checks[i]
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                            'assets/icons/grey_check.png'),
                                      )
                                    : SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                            'assets/icons/check.png'),
                                      ),
                              ),
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

final List<bool> _checks =
    List.generate(Content.hobbiesList.length, (_) => false);

final List<String> name = [
  'Working out',
  'Hiking',
  'Biking',
  'Shopping',
  'Cooking',
  'Baking',
  'Drinking',
  'Reading',
];
