import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

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
            AppLocalizations.of(context)!.privacyPolicy,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: SingleChildScrollView(
            child: Text(
              style: TextStyle(height: 1.4),
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc sed augue lacus viverra. Enim blandit volutpat maecenas volutpat blandit aliquam etiam erat velit. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui. Odio morbi quis commodo odio aenean. Massa vitae tortor condimentum lacinia quis vel eros. Molestie at elementum eu facilisis. Sed odio morbi quis commodo odio. Hendrerit gravida rutrum quisque non tellus orci ac auctor augue. Risus nec feugiat in fermentum posuere urna. Vulputate ut pharetra sit amet aliquam id. Facilisi nullam vehicula ipsum a arcu cursus vitae. Ligula ullamcorper malesuada proin libero. Turpis massa sed elementum tempus egestas sed sed. Urna neque viverra justo nec ultrices dui sapien.'
              'Cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Non sodales neque sodales ut etiam. Id venenatis a condimentum vitae sapien pellentesque habitant. In iaculis nunc sed augue lacus viverra. Eget mi proin sed libero. Facilisis mauris sit amet massa vitae. '
              'Platea dictumst quisque sagittis purus sit amet. Malesuada fames ac turpis egestas maecenas. Euismod in pellentesque massa placerat duis ultricies lacus sed turpis. Quam nulla porttitor massa id neque aliquam vestibulum morbi blandit.'
              ' Hachabitasseplatea dictumst vestibulum rhoncus est pellentesque elit ullamcorper. Convallis posuere morbi leo urna molestie at.'
              ' Pretium viverra suspendisse potenti nullam ac tortor vitae purus. Netus et malesuada fames ac turpis egestas maecenas pharetra convallis.'
              'Tempor commodo ullamcorper a lacus. Arcu non sodales neque sodales ut etiam sit amet. Purus in massa tempor nec feugiat nisl pretium fusce id.'
              ' Massa placerat duis ultricies lacus. Ultricies leo integer malesuada nunc vel risus commodo viverra. Massa tempor nec feugiat nisl pretium fusce id velit. Aliquet porttitorlacusluctus accumsan. Quisque sagittis purus sit amet '
              'volutpat consequat. Viverra mauris in aliquam sem fringilla utmorbi. Quisque non tellus orci ac. Semper risus in hendrerit gravida rutrum. Diam quam nulla porttitor massaid.'
              'Elit ut aliquam purus sit ametluctus venenatis lectus magna. Nisl suscipit adipiscing bibendum estultricies. Vel pretium lectus quam id leo. Loremipsum dolor sit amet consectetur adipiscing.',
              textAlign: TextAlign.justify,
            ),
          ),
        ));
  }
}
