import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> faqHeader = [
      AppLocalizations.of(context)!.cancellingSubscription,
      AppLocalizations.of(context)!.unableSignin,
      AppLocalizations.of(context)!.emailPasswordIssue,
    ];
    List<String> faqBody = [
      AppLocalizations.of(context)!.cancelSubText,
      AppLocalizations.of(context)!.unableSignText,
      AppLocalizations.of(context)!.emailIssue,
    ];
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
        title: const Text(
          'Faq\'s',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
          itemCount: faqHeader.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.transparent,
                  unselectedWidgetColor: Colors.black,
                  primaryColor: Colors.black,
                ),
                child: ExpansionTile(
                  title: Text(
                    faqHeader[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        faqBody[index],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
