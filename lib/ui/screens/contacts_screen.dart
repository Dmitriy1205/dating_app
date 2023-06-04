import 'package:dating_app/core/services/cache_helper.dart';
import 'package:dating_app/ui/bloc/contacts_cubit.dart';
import 'package:dating_app/ui/bloc/stories/stories_cubit.dart';
import 'package:dating_app/ui/screens/messenger_screen.dart';
import 'package:dating_app/ui/screens/video_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dating_app/core/services/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/constants.dart';
import '../bloc/messenger_cubit.dart';
import '../bloc/register_call/register_call_cubit.dart';
import '../widgets/search_bar.dart';
import '../widgets/stories_bar.dart';
import 'history_call_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late ContactsCubit bloc;
  late TextEditingController controller;

  @override
  void initState() {
    bloc = sl<ContactsCubit>();
    context.read<StoriesCubit>().fetchAllStories();
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCallCubit, RegisterCallState>(
      listener: (context, state) {
        if (state.inCallStatus == IncomingCallStatus.successOuterCall) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => VideoCallScreen(
                    receiverId: state.callModel!.receiverId!,
                    id: state.callModel!.id,
                    isReceiver: false,
                  )));
        } else if (state.status!.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
              content: Text(
                state.status!.errorMessage!,
              ),
            ),
          );
        }
      },
      child: BlocProvider.value(
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
                  const Spacer(),
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
                            builder: (_) => HistoryCallScreen(
                                  callHistory: bloc.state.callHistory!,
                                )));
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
                    AnimationSearchBar(
                      hintText: AppLocalizations.of(context)!.searchContact,
                      leadingWidget: Text(
                        '${state.usersList!.length.toString()} ${AppLocalizations.of(context)!.connections}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      horizontalPadding: 10,
                      centerTitle: '',
                      onChanged: (String s) {
                        context.read<ContactsCubit>().searchContact(s);
                      },
                      onFinishSearch: () {
                        context.read<ContactsCubit>().updateConnections();
                      },
                      searchTextEditingController: controller,
                    ),
                    const StoriesBar(),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.6,
                      child: state.search == Search.searching
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange,
                              ),
                            )
                          : state.search == Search.found
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.foundedUsersList!.length,
                                  itemBuilder: (context, index) {
                                    context.read<ContactsCubit>().getUrlImage(
                                        state.foundedUsersList![index].id!);

                                    return GestureDetector(
                                      onTap: () {
                                        bloc.palUser =
                                            state.foundedUsersList![index];
                                        CacheHelper.saveData(
                                            key: 'uId',
                                            value: state.currentUserId);
                                        MessengerScreen(
                                            user:
                                                state.foundedUsersList![index],
                                            userPicture: state
                                                .foundedUsersList![index]
                                                .profileInfo!
                                                .image!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                              value: bloc,
                                              child: BlocProvider.value(
                                                value: sl<MessengerCubit>(),
                                                child: MessengerScreen(
                                                  currentUserName:
                                                      state.currentUserName,
                                                  currentUserid:
                                                      state.currentUserId,
                                                  user: bloc.palUser,
                                                  userPicture: state
                                                      .foundedUsersList![index]
                                                      .profileInfo!
                                                      .image!,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15,
                                                      bottom: 15,
                                                      right: 15,
                                                    ),
                                                    child: SizedBox(
                                                      height: 75,
                                                      width: 75,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: state
                                                                    .foundedUsersList![
                                                                        index]
                                                                    .profileInfo!
                                                                    .image! !=
                                                                ''
                                                            ? Image.network(
                                                                state
                                                                    .foundedUsersList![
                                                                        index]
                                                                    .profileInfo!
                                                                    .image!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Stack(
                                                                fit: StackFit
                                                                    .expand,
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/images/empty.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  const Center(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'No Avatar',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
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
                                                        const EdgeInsets.only(
                                                            top: 35),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state
                                                              .foundedUsersList![
                                                                  index]
                                                              .firstName!,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                  })
                              : state.search == Search.noMatch
                                  ? SizedBox(
                                      child: Center(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .contactNotExist)),
                                    )
                                  : buildListView(state),
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
          )),
    );
  }

  ListView buildListView(
    ContactsCubitStates state,
  ) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.usersList!.length,
        itemBuilder: (context, index) {
          context
              .read<ContactsCubit>()
              .getUrlImage(state.usersList![index].id!);

          return GestureDetector(
            onTap: () {
              bloc.palUser = state.usersList![index];
              CacheHelper.saveData(key: 'uId', value: state.currentUserId);
              MessengerScreen(
                  user: state.usersList![index],
                  userPicture: state.usersList![index].profileInfo!.image!);
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
                        userPicture:
                            state.usersList![index].profileInfo!.image!,
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            right: 15,
                          ),
                          child: SizedBox(
                            height: 75,
                            width: 75,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: state.usersList![index].profileInfo!
                                          .image! !=
                                      ''
                                  ? Image.network(
                                      state.usersList![index].profileInfo!
                                          .image!,
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
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'No Avatar',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.usersList![index].firstName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
        });
  }
}
