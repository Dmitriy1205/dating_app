import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  const Messenger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: const EdgeInsets.fromLTRB(23, 8, 8, 8),
            onPressed: () {
              Navigator.pop(context);
            },
            splashRadius: 0.1,
            iconSize: 28,
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          title: Text('Connections',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        ),
        body: Container());
  }
}
