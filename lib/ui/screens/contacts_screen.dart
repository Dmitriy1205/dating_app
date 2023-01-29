import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:dating_app/core/services/cache_helper.dart';
import 'package:dating_app/ui/bloc/contacts_cubit.dart';
import 'package:dating_app/ui/screens/messenger_screen.dart';
import 'package:dating_app/ui/widgets/status_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dating_app/core/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/messenger_cubit.dart';
import 'history_call_screen.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late ContactsCubit bloc;
  late TextEditingController controller;

  @override
  void initState() {
    bloc = sl<ContactsCubit>();
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: bloc,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade50,
            leading: IconButton(
              padding: const EdgeInsets.fromLTRB(23, 15, 8, 8),
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
            title: Row(
              children: [
                Spacer(),
                Text(
                  AppLocalizations.of(context)!.connections,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const HistoryCallScreen()));
                    },
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Image.asset(
                          'assets/icons/call.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: BlocBuilder<ContactsCubit, ContactsCubitStates>(
              builder: (context, state) {
            if (state.status!.isLoaded) {
              return ListView(
                children: [
                  const Divider(
                    thickness: 0.3,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child:
                    // AnimationSearchBar(
                    //   centerTitle: '',
                    //   isBackButtonVisible: false,
                    //   onChanged: (String) {},
                    //   searchTextEditingController: controller,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${state.usersList!.length.toString()} ${AppLocalizations.of(context)!.connections}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    height: 120,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 15),
                            child: GestureDetector(
                              onTap: () {
                                StatusBottomSheet().showPicker(
                                  context,
                                );
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.orangeAccent,
                                                width: 3),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: state.currentUserAvatar != null
                                              ? Image.asset(
                                                  'assets/images/empty.png',
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  state.currentUserAvatar!,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(AppLocalizations.of(context)!
                                          .myStatus),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    right: 0,
                                    child: SizedBox(
                                      height: 36,
                                      width: 36,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Image.asset(
                                          'assets/icons/plus.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: state.usersList!.length,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.only(right: 1),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Container(
                          //               height: 75,
                          //               width: 75,
                          //               decoration: BoxDecoration(
                          //                   border: Border.all(
                          //                       color: Colors.orange, width: 3),
                          //                   borderRadius:
                          //                       BorderRadius.circular(50)),
                          //               child: ClipRRect(
                          //                 borderRadius: BorderRadius.circular(50),
                          //                 child: state.image?[index] == null ||
                          //                         state.image?[index] != ''
                          //                     ? Image.network(
                          //                         state.image![index],
                          //                         fit: BoxFit.cover,
                          //                       )
                          //                     : Stack(
                          //                         fit: StackFit.expand,
                          //                         children: [
                          //                           Image.asset(
                          //                             'assets/images/empty.png',
                          //                             fit: BoxFit.cover,
                          //                           ),
                          //                           const Center(
                          //                             child: Padding(
                          //                               padding:
                          //                                   EdgeInsets.all(8.0),
                          //                               child: Text(
                          //                                 'No Avatar',
                          //                                 textAlign:
                          //                                     TextAlign.center,
                          //                                 style: TextStyle(
                          //                                     fontSize: 10,
                          //                                     fontWeight:
                          //                                         FontWeight
                          //                                             .bold),
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               height: 5,
                          //             ),
                          //             Text(state.usersList![index].firstName!),
                          //           ],
                          //         ),
                          //       );
                          //     }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.usersList!.length,
                        itemBuilder: (context, index) {
                          context
                              .read<ContactsCubit>()
                              .getUrlImage(state.usersList![index].id!);

                          return GestureDetector(
                            onTap: () {
                              bloc.palUser = state.usersList![index];
                              CacheHelper.saveData(
                                  key: 'uId', value: state.currentUserId);
                              MessengerScreen(
                                  user: state.usersList![index],
                                  userPicture: state.image![index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: bloc,
                                    child: BlocProvider.value(
                                      value: sl<MessengerCubit>(),
                                      child: MessengerScreen(
                                        currentUserName: state.currentUserName,
                                        currentUserid: state.currentUserId,
                                        user: bloc.palUser,
                                        userPicture: state.image![index],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.grey.shade200,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 15,
                                            bottom: 15,
                                            right: 15,
                                          ),
                                          child: Container(
                                            height: 75,
                                            width: 75,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: state.image?[index] ==
                                                          null ||
                                                      state.image?[index] != ''
                                                  ? Image.network(
                                                      state.image![index],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/empty.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        const Center(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              'No Avatar',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 35),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.usersList![index]
                                                    .firstName!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                'Message',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 0.3,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return Center(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Updating your Contacts..'),
                      LinearProgressIndicator(
                        minHeight: 15,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.orange.shade900),
                        backgroundColor: Colors.orangeAccent,
                      )
                    ],
                  ),
                ),
              );
            }
          }),
        ));
  }
}
