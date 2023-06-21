import 'dart:typed_data';
import 'dart:ui';

import 'package:dating_app/ui/bloc/stories/stories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStories extends StatefulWidget {
  const AddStories({Key? key}) : super(key: key);

  @override
  State<AddStories> createState() => _AddStoriesState();
}

class _AddStoriesState extends State<AddStories> {
  final globalKey = GlobalKey();

  final _controller = TextEditingController();

  final _focusNode = FocusNode();

  bool showCursor = true;

  Future<Uint8List> _saveStory(BuildContext context) async {
    final renderObject =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final imageBytes = await renderObject
        .toImage(pixelRatio: 1.0)
        .then((image) => image.toByteData(format: ImageByteFormat.png));
    final imageData = imageBytes!.buffer.asUint8List();

    return imageData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(radius: 1, colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade700
                  ])),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Center(
                    child: EditableText(
                        autofocus: true,
                        showCursor: showCursor,
                        maxLines: 7,
                        autocorrect: false,
                        controller: _controller,
                        focusNode: _focusNode,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        cursorColor: Colors.white,
                        backgroundCursorColor: Colors.white,
                      onChanged: (v){
                          setState((){
                            showCursor = false;
                          });

                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(),
          Positioned(
            top: 60,
            left: 20,
            child: SizedBox(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: IconButton(
              onPressed: () async {
                final image = await _saveStory(context);
                if (mounted) {
                  context.read<StoriesCubit>().publish(image: image);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
