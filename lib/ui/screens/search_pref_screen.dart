import 'package:dating_app/ui/bloc/search_preferences_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/service_locator.dart';
import '../widgets/search_pref_form.dart';

class SearchPrefScreen extends StatelessWidget {
  const SearchPrefScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchPreferencesCubit>(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SearchPrefForm(),
        ),
      ),
    );
  }
}
