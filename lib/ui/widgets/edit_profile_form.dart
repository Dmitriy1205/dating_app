import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  ReUsableWidgets reUsableWidgets = ReUsableWidgets();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      child: Image.asset('assets/icons/photo.png')),
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
    );
  }
}
