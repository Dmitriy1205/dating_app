import 'package:dating_app/core/constants.dart';
import 'package:dating_app/ui/bloc/contacts_cubit.dart';
import 'package:dating_app/ui/screens/messenger_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dating_app/core/service_locator.dart' as sl;



class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late ContactsCubit bloc;

  @override
  void initState() {
    bloc = ContactsCubit();
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
              title: const Text(
                'Connections',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocBuilder<ContactsCubit, ContactsCubitStates>(
                builder: (context, state) {
              if (state is ContactsCubitInitState) {
                return ListView(
                  children: [
                    const Divider(
                      thickness: 0.3,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${state.usersList!.length.toString()} Connections',
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.usersList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        Content.hobbiesList[index],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(state.usersList[index].firstName!),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.usersList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                sl.userModel = state.usersList[index];
                                // MessengerScreen(user: state.usersList[index]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider.value(
                                              value: bloc,
                                              child: MessengerScreen(
                                                  user: state.usersList[index]),
                                            )));
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
                                              height: 85,
                                              width: 85,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.asset(
                                                  Content.hobbiesList[index],
                                                  fit: BoxFit.fill,
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
                                                  state.usersList[index]
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
                return const Text('ERROR');
              }
            }),
          ));

  }
}
