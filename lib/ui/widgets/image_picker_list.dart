import 'dart:io';

import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../bloc/image_picker/image_picker_cubit.dart';

class ImagePickerList extends StatelessWidget {
  final Function(String) userImage;

  const ImagePickerList({Key? key, required this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ImagePickerCubit>(),
      child: _ImagePickerList(
        userImage: userImage,
      ),
    );
  }
}

class _ImagePickerList extends StatelessWidget {
  final Function(String) userImage;

  _ImagePickerList({Key? key, required this.userImage}) : super(key: key);
  int _itemCount = 0;
  ReUsableWidgets reUsableWidget = ReUsableWidgets();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        var list = state.image;
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
                    reUsableWidget.showPicker(
                      context,
                      func: (File? f) {
                        context
                            .read<ImagePickerCubit>()
                            .uploadImage(f!, '${_itemCount++}')
                            .whenComplete(() => context
                                .read<ImagePickerCubit>()
                                .getAllImages());
                        userImage(list!.last);
                      },
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: state.status!.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Image.asset('assets/icons/photo.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              list == null
                  ? const SizedBox()
                  : ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Card(
                              elevation: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  list.reversed.toList()[index],
                                  width: 150,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            ],
          ),
        );
      },
    );
  }
}
