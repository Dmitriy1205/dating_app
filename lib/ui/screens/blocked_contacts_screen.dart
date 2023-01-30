import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/blocked_contacts/blocked_contacts_cubit.dart';

class BlockedContactsScreen extends StatelessWidget {
  const BlockedContactsScreen({Key? key}) : super(key: key);

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
          AppLocalizations.of(context)!.blockedContacts,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<BlockedContactsCubit, BlockedContactsState>(
        builder: (context, state) {
          if (state.status!.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }
          final contact = context.read<BlockedContactsCubit>().state;
          return contact.usersList == null
              ? SizedBox()
              : ListView.builder(
                  itemCount: contact.usersList?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        child: contact.usersList![index]
                                                .profileInfo!.image!.isEmpty
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Image.network(
                                                contact.usersList![index]
                                                    .profileInfo!.image!,
                                          fit: BoxFit.fill,
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
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<BlockedContactsCubit>()
                                        .unblockContact(contact.usersList![index].id!);

                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: Colors.transparent,
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment(0.1, 1.5),
                                          colors: [
                                            Colors.orange,
                                            Colors.purple,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Container(
                                      width: 75,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.undo,
                                      ),
                                    ),
                                  ),
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
