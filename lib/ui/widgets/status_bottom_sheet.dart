import 'dart:typed_data';
import 'package:dating_app/ui/bloc/stories/stories_cubit.dart';
import 'package:dating_app/ui/widgets/add_stories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatusBottomSheet {

  void showPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 25,
                    left: MediaQuery.of(context).size.width / 13,
                    right: MediaQuery.of(context).size.width / 13,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          ListTile(
                              title: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Image.asset(
                                          'assets/icons/image.png',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.addImage,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                imageFromCamera(getPhoto: (Uint8List? f) {
                                  context.read<StoriesCubit>().publish(image: f!);
                                });
                                Navigator.of(context).pop();
                              }),
                          ListTile(
                              title: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Image.asset(
                                          'assets/icons/edit.png',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.addText,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, page) =>
                                          const AddStories(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(0.0, 1.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ));
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 35,
                    left: MediaQuery.of(context).size.width / 17,
                    right: MediaQuery.of(context).size.width / 17,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
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
                        child: Text(
                          AppLocalizations.of(context)!.cancel.toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // Future imageFromGallery({required Function(File?) getImage}) async {
  //   final ImagePicker picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 480,
  //     maxHeight: 640,
  //     imageQuality: 100,
  //   );
  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path);
  //     getImage(_image!);
  //   } else {
  //     // print('No image selected.');
  //   }
  // }

  Future imageFromCamera({required Function(Uint8List?) getPhoto}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 480,
      maxHeight: 640,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      final Uint8List imageData = await pickedFile.readAsBytes();
      getPhoto(imageData);
    } else {}
  }
}
