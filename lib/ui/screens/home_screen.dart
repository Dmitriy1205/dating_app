import 'package:dating_app/ui/bloc/home/home_cubit.dart';
import 'package:dating_app/ui/bloc/register_call/register_call_cubit.dart';
import 'package:dating_app/ui/screens/contacts_screen.dart';
import 'package:dating_app/ui/screens/profile_screen.dart';
import 'package:dating_app/ui/screens/video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../core/service_locator.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<RegisterCallCubit, RegisterCallState>(
        listener: (context, state) {
          if (state.inCallStatus == IncomingCallStatus.successIncomingCall) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => VideoCallScreen(
                      receiverId: state.callModel!.receiverId!,
                      id: state.callModel!.id,
                      isReceiver: true,
                    )));
          }
        },
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactsScreen()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfileScreen()));
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
                            Navigator.pushNamed(context, 'filter');
                          },
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child:
                                      Image.asset('assets/icons/menu.png')))),
                    ),
                  ],
                ),
              ],
            ),
            elevation: 0,
          ),
          body: BlocProvider(
            create: (context) => sl<HomeCubit>(),
            child: const HomeBody1(),
          ),
        ),
      ),
    );
  }
}

// @override
// void initState() {
//   Future.delayed(const Duration(milliseconds: 1000), () {
//     checkInComingTerminatedCall();
//   });
//   super.initState();
// }
//
// checkInComingTerminatedCall() async {
//   if (CacheHelper.getString(key: 'terminateIncomingCallData').isNotEmpty) {
//     //if there is a terminated call
//     Map<String, dynamic> callMap =
//     jsonDecode(CacheHelper.getString(key: 'terminateIncomingCallData'));
//     await CacheHelper.removeData(key: 'terminateIncomingCallData');
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (contex) => VideoCallScreen(
//                 receiverId: context
//                     .read<RegisterCallCubit>()
//                     .state
//                     .callModel!
//                     .receiverId!,
//                 id: CacheHelper.getString(key: 'uId'),
//                 isReceiver: true)));
//   }
// }
