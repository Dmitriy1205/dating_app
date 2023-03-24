import 'package:dating_app/ui/bloc/filter/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/service_locator.dart';
import '../widgets/filter_form.dart';

class FilterScreen extends StatelessWidget {
  static const String id = 'filter';

  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child:  Text(
                  AppLocalizations.of(context)!.reset,
                  style: const TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ],
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 0.1,
          iconSize: 28,
          alignment: Alignment.center,
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.filter,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: BlocProvider.value(
        value: sl<FilterCubit>(),
        child: FilterForm(),
      ),
    );
  }
}
