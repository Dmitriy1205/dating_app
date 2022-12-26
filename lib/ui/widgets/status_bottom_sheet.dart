import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StatusBottomSheet {
  File? _image;

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
                  padding: const EdgeInsets.all(22),
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
                                    SizedBox(
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
                                imageFromCamera(getPhoto: (File? f) {
                                  // func(f);
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
                                    SizedBox(
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
                                // imageFromGallery(getImage: (File? f) {
                                //   func(f);
                                // });
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22,right: 22,bottom: 22),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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

  Future imageFromCamera({required Function(File?) getPhoto}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 480,
      maxHeight: 640,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      getPhoto(_image!);
    } else {
      print('No image selected.');
    }
  }
}
