import 'package:dating_app/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(23, 15, 8, 8),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 0.1,
          iconSize: 28,
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  //TODO: navigation to settings
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                },
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image.asset('assets/icons/settings.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Image.asset('assets/images/pic.png',),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: Image.asset('assets/images/hiking.png',),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: Image.asset('assets/images/biking.png',fit: BoxFit.contain,),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Image.asset('assets/images/politics.png',fit: BoxFit.contain,),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Image.asset('assets/images/politics.png',fit: BoxFit.contain,),
                  ),

                  // Image.asset('assets/images/politics.png'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Username',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'name',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Birthday',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'date',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Gender',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'gender',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'About',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
                    'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '
                    'enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                    'nisi ut aliquip ex ea .',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Basic Profile',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Height : ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        '164 cm',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Relationship Status : ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'single',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Joined Date : ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'int cm',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Looking For : ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Friend..',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Current Location : ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'city, country',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(
              color: Colors.grey.shade400,
            ),
            //TODO: down chips
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Interests',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //TODO: Chips with Interests
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            //TODO: down chips
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hobbies',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //TODO: Chips with Interests
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  onPressed: () {},
                  // isChecked == false
                  //     ? null
                  //     : () {
                  // submit(context);
                  // if (!_formKey.currentState!.validate()) {
                  //   return;
                  // }
                  //
                  // _formKey.currentState!.save();
                  //TODO: Add phone auth with email link auth to signup
                  // context.read<AuthCubit>().signUp(
                  //       phoneNumber: _phoneController.text,
                  //       verificationId: verificationId,
                  //       navigateTo: Navigator.push<void>(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) =>
                  //               const OtpVerificationScreen(),
                  //         ),
                  //       ),
                  //     );

                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment(0.1, 2.1),
                          colors: [
                            Colors.orange,
                            Colors.purple,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      width: 340,
                      height: 55,
                      alignment: Alignment.center,
                      child: const Text(
                        'EDIT PROFILE',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
