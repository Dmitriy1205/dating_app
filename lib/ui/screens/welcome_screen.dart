import 'package:dating_app/ui/screens/reflow_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/constants.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Image.asset(
              Content.welcome,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 250,
              child: Container(
                height: 50,
                width: 240,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text('Select Language'),
                    offset: const Offset(0, -18),
                    dropdownDecoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10)),
                    buttonDecoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10)),
                    // value: '',
                    onChanged: (value) {
                      MenuItems.onChanged(context, value as MenuItem);
                    },
                    items: [
                      ...MenuItems.items.map(
                            (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      // const DropdownMenuItem<Divider>(),
                      // ...MenuItems.secondItems.map(
                      //   (item) => DropdownMenuItem<MenuItem>(
                      //     value: item,
                      //     child: MenuItems.buildItem(item),
                      //   ),
                      // ),
                    ],
                    // items: items,
                  ),
                ),
                // DropdownButtonFormField(
                //   items: ['Eng', 'De'],
                //   onItemChanged: (String item) async {
                //     if (item == 'De') {
                //       Locale german =
                //       const Locale.fromSubtags(languageCode: 'de');
                //       locale.state = german;
                //     } else {
                //       Locale english =
                //       const Locale.fromSubtags(languageCode: 'en');
                //       locale.state = english;
                //     }
                //   },
                // )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
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
                            borderRadius: BorderRadius.circular(50))),
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
                        child: Text(
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
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
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
        ),
      ),
    );
  }
}
class MenuItem {
  final String text;
  final String icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> items = [en, es, fr, pt];

  static const en = MenuItem(text: 'English', icon: 'assets/icons/en.png');
  static const es = MenuItem(text: 'Espanol', icon: 'assets/icons/es.png');
  static const fr = MenuItem(text: 'Frencais', icon: 'assets/icons/fr.png');
  static const pt = MenuItem(text: 'Portugese', icon: 'assets/icons/pt.png');

  static Widget buildItem(MenuItem item) {
    return Wrap(
        children: [Row(
          children: [
            SizedBox(
              child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  item.icon,

                  height: 35,
                  width: 35,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              item.text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),]
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.en:
      //Do something
        break;
      case MenuItems.es:
      //Do something
        break;
      case MenuItems.fr:
      //Do something
        break;
      case MenuItems.pt:
      //Do something
        break;
    }
  }
}