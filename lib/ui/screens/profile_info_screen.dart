import 'package:dating_app/ui/widgets/profile_info_form.dart';
import 'package:flutter/material.dart';

class ProfileInfoScreen extends StatelessWidget {
  final String name;
  final String date;
  const ProfileInfoScreen({Key? key, required this.name, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:  Scaffold(
        body: ProfileInfoFrom(name:name,date:date),
      ),
    );
  }
}
