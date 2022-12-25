import 'dart:io';

import 'package:dating_app/ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/image_picker/image_picker_cubit.dart';

class ImagePickerList extends StatelessWidget {
  final Function(String) userImage;

  const ImagePickerList({Key? key, required this.userImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ImagePickerList(
      userImage: userImage,
    );
  }
}

class _ImagePickerList extends StatelessWidget {
  final Function(String) userImage;

  _ImagePickerList({Key? key, required this.userImage}) : super(key: key);
  int _itemCount = 0;
  ReUsableWidgets reUsableWidget = ReUsableWidgets();
  int? _selected;

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
                        userImage(list!.first);
                      },
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Center(
                      child: SizedBox(
                        height: 55,
                        width: 55,
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
                          child: InkWell(
                            onTap: () {
                              _selected = index;
                              context
                                  .read<ImagePickerCubit>()
                                  .switcher(_selected!);
                              // picked = !picked;
                              userImage(list[index]);
                              print(list[index]);
                            },
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: index == _selected
                                      ? Border.all(
                                          color: Colors.orange, width: 3)
                                      : Border.all(color: Colors.transparent)),
                              child: Card(
                                elevation: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.network(
                                        list[index],
                                        width: 150,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      index == _selected
                                          ? SizedBox(
                                              child: Image.asset(
                                                'assets/icons/check.png',
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
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
