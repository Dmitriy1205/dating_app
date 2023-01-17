class Content {
  static const String logo = 'assets/images/logo.png';
  static const String reflow = 'assets/images/comm.png';
  static const String signUp = 'assets/images/up.png';
  static const String login = 'assets/images/login.png';
  static const String profile = 'assets/images/profile.png';
  static const String welcome = 'assets/images/welcome.png';
  static const String outgoingCall = 'assets/sounds/outgoing_call.mp3';
  static const String incomingCall = 'assets/sounds/incoming_call.mp3';

  static const List<String> hobbiesList = [
    'assets/images/working_out.png',
    'assets/images/reading.png',
    'assets/images/cooking.png',
    'assets/images/biking.png',
    'assets/images/drinking.png',
    'assets/images/shopping.png',
    'assets/images/hiking.png',
    'assets/images/baking.png',
  ];

  static const List<String> interestsList = [
    'assets/images/photography.png',
    'assets/images/acting.png',
    'assets/images/film.png',
    'assets/images/fine_arts.png',
    'assets/images/music.png',
    'assets/images/fashion.png',
    'assets/images/dance.png',
    'assets/images/politics.png',
  ];
  static const List<String> settingsList = [
    'assets/icons/notifications.png',
    'assets/icons/blocked.png',
    'assets/icons/friends.png',
    'assets/icons/faq.png',
    'assets/icons/terms.png',
    'assets/icons/privacy.png',
    'assets/icons/logout.png',
  ];
  static const List<String> settingNames = [
    'Notifications',
    'Blocked Contacts',
    'Friend List',
    'Faq\'s',
    'Terms & Conditions',
    'Privacy Policy',
    'Logout'
  ];
  static const List<String> faqHeader = [
    'Cancelling a subscription-',
    'Unable to signin-',
    'Email/Password issue-',
  ];
  static const List<String> faqBody = [
    'if you were interested for canceling a subscription'
        ' or you havedecided to turn auto subscription'
        ' renuwal',
    'if you having problem with signin, please review'
        ' the information below to help troubleshoot the problem',
    'Friend List',
  ];
  static const List<String> name = [
    'Politics',
    'Fashion',
    'Fine Arts',
    'Music',
    'Dance',
    'Film',
    'Photography',
    'Acting',
  ];
}

const appId = '8bbfa04b43d140398c646fe860e771ca';
const testToken =
'007eJxTYPiX+/7+gxtPf900mTJ13Uut/OUte4S8j9yYYK93PM44MGqyAoNFUlJaooFJkolxiqGJgbGlRbKZiVlaqoWZQaq5uWFyYlneseSGQEaGyq3rGBkZIBDEZ2VIyyktKWFgAAClMiNx';
const testChannel = 'flutt';
const int callDurationInSec = 15;

enum CallStatus {
  none,
  ringing,
  accept,
  reject,
  unAnswer,
  cancel,
  end,
}

enum IncomingCallStatus {
  successOuterCall,
  successIncomingCall,
}

class CustomIcons {
  static const String checkbox = 'assets/icons/check.png';
  static const String photo = 'assets/icons/photo.png';
  static const String sendMessage = 'assets/icons/send_message_icon.png';
  static const String attachMessage = 'assets/icons/attach_message_icon.png';
}
