import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants.dart';
import '../screens/hobbies_screen.dart';
import '../screens/interests_screen.dart';
import '../screens/search_pref_screen.dart';

class ProfileInfoFrom extends StatefulWidget {
  const ProfileInfoFrom({Key? key}) : super(key: key);

  @override
  State<ProfileInfoFrom> createState() => _ProfileInfoFromState();
}

class _ProfileInfoFromState extends State<ProfileInfoFrom> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  ReUsableWidgets reUsableWidgets = ReUsableWidgets();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Content.profile,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Form(
                    key: _formKey,
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
                                  'Profile Info',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchPrefScreen(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child:
                                        Image.asset('assets/icons/check.png'))),
                            // const Icon(
                            //   Icons.check,
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 230,
                          width: double.infinity,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 150,
                                child: GestureDetector(
                                  onTap: () {
                                    reUsableWidgets.showPicker(context);
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: Center(
                                      child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset(
                                              'assets/icons/photo.png')),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              //TODO: add horizontal lisview.builder to make row of pictures from storage
                              const SizedBox(
                                height: 200,
                                width: 150,
                                child: Card(
                                  elevation: 5,
                                  child: Center(),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const SizedBox(
                                height: 200,
                                width: 150,
                                child: Card(
                                  elevation: 5,
                                  child: Center(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        reUsableWidgets.generalInfoEditWidget(),
                        reUsableWidgets.openHobbiesOrInterestst(
                            context, 'Hobbies'),
                        reUsableWidgets.openHobbiesOrInterestst(
                            context, 'Interests'),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void submit(context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
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
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
