import 'package:dating_app/ui/bloc/stories/stories_cubit.dart';
import 'package:dating_app/ui/screens/stories_screen.dart';
import 'package:dating_app/ui/widgets/status_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'loading_indicator.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoriesCubit, StoriesState>(
      builder: (context, state) {
        if (state.status!.isLoading) {
          return const LoadingIndicator();
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            color: Colors.grey.shade200,
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 15),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                state.currentUserStories == null ||
                                        state.currentUserStories!.isEmpty
                                    ? null
                                    : Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  page) =>
                                              StoriesScreen(
                                                  stories:
                                                      state.currentUserStories),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(0.0, 1.0);
                                            const end = Offset.zero;
                                            const curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                        ));
                              },
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.orangeAccent, width: 3),
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: state.currentUserStories == null ||
                                          state.currentUserStories!.isEmpty
                                      ? Image.asset(
                                          'assets/images/empty.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Transform.scale(
                                          scale: 1.7,
                                          alignment: Alignment.topCenter,
                                          child: Image.network(
                                            state.currentUserStories!.last
                                                .image!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(AppLocalizations.of(context)!.myStatus),
                          ],
                        ),
                        Positioned(
                          bottom: 30,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              StatusBottomSheet().showPicker(
                                context,
                              );
                            },
                            child: SizedBox(
                              height: 36,
                              width: 36,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Image.asset(
                                  'assets/icons/plus.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.usersStory != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.usersStory!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return state.usersStory![index].stories!.isEmpty ? const SizedBox(): Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (context, animation, page) =>
                                                    StoriesScreen(
                                                        stories: state
                                                            .usersStory![index]
                                                            .stories),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              const begin = Offset(0.0, 1.0);
                                              const end = Offset.zero;
                                              const curve = Curves.ease;

                                              var tween = Tween(
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));

                                              return SlideTransition(
                                                position:
                                                    animation.drive(tween),
                                                child: child,
                                              );
                                            },
                                          ));
                                    },
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.orange, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: state.usersStory![index].stories != null
                                            ?  Transform.scale(
                                                scale: 1.5,
                                                alignment: Alignment.topCenter,
                                                child: Image.network(
                                                  state.usersStory![index]
                                                      .stories!.last.image!,
                                                  fit: BoxFit.fill,
                                                ),
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
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(state.usersStory![index].name!
                                      .split(' ')[0]),
                                ],
                              ),
                            );
                          })
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
