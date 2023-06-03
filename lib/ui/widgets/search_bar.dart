import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/service_locator.dart';
import '../bloc/search/search_cubit.dart';

class AnimationSearchBar extends StatelessWidget {
  AnimationSearchBar({
    Key? key,
    this.searchBarWidth,
    this.searchBarHeight,
    this.previousScreen,
    this.backIconColor,
    this.closeIconColor,
    this.searchIconColor,
    this.centerTitle,
    this.centerTitleStyle,
    this.searchFieldHeight,
    this.searchFieldDecoration,
    this.cursorColor,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    required this.onChanged,
    required this.searchTextEditingController,
    this.horizontalPadding,
    this.verticalPadding,
    this.isBackButtonVisible,
    this.leadingWidget,
    this.duration,
    required this.onFinishSearch,
  }) : super(key: key);

  ///
  final double? searchBarWidth;
  final double? searchBarHeight;
  final double? searchFieldHeight;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? previousScreen;
  final Color? backIconColor;
  final Color? closeIconColor;
  final Color? searchIconColor;
  final Color? cursorColor;
  final String? centerTitle;
  final String? hintText;
  final bool? isBackButtonVisible;
  final Widget? leadingWidget;
  final TextStyle? centerTitleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Decoration? searchFieldDecoration;
  late Duration? duration;
  final TextEditingController searchTextEditingController;
  final Function(String) onChanged;
  final Function() onFinishSearch;

  @override
  Widget build(BuildContext context) {
    final dDuration = duration ?? const Duration(milliseconds: 500);
    final sSearchFieldHeight = searchFieldHeight ?? 40;
    final hPadding = horizontalPadding != null ? horizontalPadding! * 2 : 0;
    final sSearchBarWidth =
        searchBarWidth ?? MediaQuery.of(context).size.width - hPadding;
    final iSBackButtonVisible = isBackButtonVisible ?? true;
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final isSearching = state.isSearching;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding ?? 0,
                vertical: verticalPadding ?? 0),
            child: SizedBox(
              width: sSearchBarWidth,
              height: searchBarHeight ?? 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  /// back Button
                  iSBackButtonVisible
                      ? AnimatedOpacity(
                          opacity: isSearching ? 0 : 1,
                          duration: dDuration,
                          child: AnimatedContainer(
                              curve: Curves.easeInOutCirc,
                              width: isSearching ? 0 : 165,
                              height: isSearching ? 0 : 25,
                              duration: dDuration,
                              child: leadingWidget),
                        )
                      : AnimatedContainer(
                          curve: Curves.easeInOutCirc,
                          width: isSearching ? 0 : 35,
                          height: isSearching ? 0 : 35,
                          duration: dDuration),

                  /// text
                  // AnimatedOpacity(
                  //   opacity: isSearching ? 0 : 1,
                  //   duration: _duration,
                  //   child: AnimatedContainer(
                  //     curve: Curves.easeInOutCirc,
                  //     width: isSearching ? 0 : _searchBarWidth - 100,
                  //     duration: _duration,
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       centerTitle ?? 'Title',
                  //       textAlign: TextAlign.center,
                  //       style: centerTitleStyle ??
                  //           const TextStyle(
                  //             fontWeight: FontWeight.w500,
                  //             color: Colors.black,
                  //             fontSize: 20,
                  //           ),
                  //     ),
                  //   ),
                  // ),

                  /// close search
                  AnimatedOpacity(
                    opacity: isSearching ? 1 : 0,
                    duration: dDuration,
                    child: AnimatedContainer(
                      curve: Curves.easeInOutCirc,
                      width: isSearching ? 35 : 0,
                      height: isSearching ? 35 : 0,
                      duration: dDuration,
                      child: FittedBox(
                        child: KCustomButton(
                          widget: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Icon(Icons.close,
                                  color: closeIconColor ?? Colors.black)),
                          onPressed: () {
                            onFinishSearch.call();
                            context.read<SearchCubit>().search(false);
                            searchTextEditingController.clear();
                          },
                        ),
                      ),
                    ),
                  ),

                  /// input panel
                  AnimatedOpacity(
                    opacity: isSearching ? 1 : 0,
                    duration: dDuration,
                    child: AnimatedContainer(
                      curve: Curves.easeInOutCirc,
                      duration: dDuration,
                      width: isSearching
                          ? sSearchBarWidth - 55 - (horizontalPadding ?? 0 * 2)
                          : 0,
                      height: isSearching ? sSearchFieldHeight : 20,
                      margin: EdgeInsets.only(
                          left: isSearching ? 5 : 0,
                          right: isSearching ? 10 : 0),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: searchFieldDecoration ??
                          BoxDecoration(
                              color: Colors.black.withOpacity(.05),
                              border:
                                  Border.all(color: Colors.black, width: .5),
                              borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        controller: searchTextEditingController,
                        cursorColor: cursorColor ?? Colors.orange,
                        style: textStyle ??
                            const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          hintText: hintText ?? 'Search contact',
                          hintStyle: hintStyle ??
                              TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w400),
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                        onChanged: onChanged,
                      ),
                    ),
                  ),

                  ///  search button
                  AnimatedOpacity(
                    opacity: isSearching ? 0 : 1,
                    duration: dDuration,
                    child: AnimatedContainer(
                      curve: Curves.easeInOutCirc,
                      duration: dDuration,
                      width: isSearching ? 0 : 35,
                      height: isSearching ? 0 : 35,
                      child: FittedBox(
                        child: KCustomButton(
                          widget: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(Icons.search,
                                  size: 50,
                                  color: searchIconColor ??
                                      Colors.black.withOpacity(.7))),
                          onPressed: () =>
                              context.read<SearchCubit>().search(true),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class KCustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? radius;

  const KCustomButton(
      {Key? key,
      required this.widget,
      required this.onPressed,
      this.radius,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 50),
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(radius ?? 50),
            child: InkWell(
                splashColor: Theme.of(context).primaryColor.withOpacity(.2),
                highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
                onTap: onPressed,
                onLongPress: onLongPress,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: widget))));
  }
}

class KBackButton extends StatelessWidget {
  final Widget? previousScreen;
  final Color? iconColor;
  final Widget? icon;

  const KBackButton(
      {Key? key,
      required this.previousScreen,
      required this.iconColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        // borderRadius: BorderRadius.circular(50),
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
                splashColor: Theme.of(context).primaryColor.withOpacity(.2),
                highlightColor: Theme.of(context).primaryColor.withOpacity(.05),
                onTap: () async {
                  previousScreen == null;
                },
                child: SizedBox(
                    // height: 30,
                    child: icon))));
  }
}
