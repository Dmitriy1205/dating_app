import 'dart:typed_data';

import 'package:dating_app/ui/widgets/loading_indicator.dart';
import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/image_picker/image_picker_cubit.dart';

class ProfileImagePicker extends StatelessWidget {
  final Function(String) userImage;

  const ProfileImagePicker({Key? key, required this.userImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AvatarPicker(
      userImage: userImage,
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  final Function(String) userImage;

  _AvatarPicker({Key? key, required this.userImage}) : super(key: key);

  ReUsableWidgets reUsableWidget = ReUsableWidgets();
  String? image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        return SizedBox(
          height: 230,
          width: double.infinity,
          child: SizedBox(
            height: 200,
            child: GestureDetector(
              onTap: () {
                reUsableWidget.showPicker(
                  context,
                  func: (Uint8List? f) {
                    context
                        .read<ImagePickerCubit>()
                        .uploadImage(f!)
                        .whenComplete(() =>
                            context.read<ImagePickerCubit>().getAllImages());

                    userImage(state.image!.first);
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(2, 2),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(-2, -2),
                      blurRadius: 8,
                    )
                  ],
                ),
                child: Center(
                  child: state.image == null || state.image!.isEmpty
                      ? SizedBox(
                          height: 55,
                          width: 55,
                          child: state.status!.isLoading
                              ? const LoadingIndicator()
                              : Image.asset('assets/icons/photo.png'),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            state.image!.first,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
