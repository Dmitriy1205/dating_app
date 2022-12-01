import 'package:dating_app/ui/widgets/profile_info_form.dart';
import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  final String name;
  const ProfileInfoScreen({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
        body: ProfileInfoFrom(name:name),
      ),
    );
  }
}
