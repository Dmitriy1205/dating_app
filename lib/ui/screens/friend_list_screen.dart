import 'package:dating_app/ui/bloc/friends_list/friends_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(23, 20, 8, 8),
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 0.1,
          iconSize: 28,
          alignment: Alignment.topLeft,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orange,
            size: 18,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.friendList,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<FriendsListCubit, FriendsListState>(
        builder: (context, state) {
          if (state.status!.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }
          final contact = context.read<FriendsListCubit>().state;
          return  contact.usersList == null ? const SizedBox() : ListView.builder(
            itemCount: contact.usersList?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: SizedBox(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 10.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 55,
                                width: 55,
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(40)),
                                  child: contact.usersList![index].profileInfo!
                                          .image!.isEmpty
                                      ? Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Image.asset(
                                              'assets/images/empty.png',
                                              fit: BoxFit.cover,
                                            ),
                                            const Center(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(8.0),
                                                child: Text(
                                                  'No Avatar',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Image.network(
                                          contact.usersList![index].profileInfo!
                                              .image!,
                                    fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                contact.usersList![index].firstName!,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
