
import 'package:dating_app/ui/screens/filter_screen.dart';
import 'package:flutter/cupertino.dart';

import '../ui/screens/home_screen.dart';

Map<String, WidgetBuilder> routes = {
  HomeScreen.id: (context) => HomeScreen(),
  FilterScreen.id:(context) => FilterScreen(),
};
