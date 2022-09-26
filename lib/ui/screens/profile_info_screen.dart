import 'package:dating_app/ui/widgets/profile_info_form.dart';
import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: ProfileInfoFrom(),
      ),
    );
  }
}
