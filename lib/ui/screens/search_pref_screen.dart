import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/search_pref_form.dart';

class SearchPrefScreen extends StatelessWidget {
  const SearchPrefScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: SearchPrefForm(),
      ),
    );
  }
}
