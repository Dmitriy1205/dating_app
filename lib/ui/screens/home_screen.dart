import 'package:dating_app/ui/bloc/home/home_cubit.dart';
import 'package:dating_app/ui/screens/contacts_screen.dart';
import 'package:dating_app/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../widgets/home_body.dart';
import 'filter_screen.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    //TODO: navigation to messenger
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactsScreen()));
                  },
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.asset('assets/icons/messenger.png'),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        //TODO: navigation to profile
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image.asset(
                            'assets/icons/profile.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                        onTap: () {
                          //TODO: navigation to filter_screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterScreen()));
                        },
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Image.asset('assets/icons/menu.png')))),
                  ),
                ],
              ),
            ],
          ),
          elevation: 0,
        ),
        body: BlocProvider(
          create: (context) => sl<HomeCubit>(),
          child: const HomeBody(),
        ),
      ),
    );
  }
}
