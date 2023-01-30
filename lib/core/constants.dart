class Content {
  static const String logo = 'assets/images/logo.png';
  static const String match = 'assets/images/match.png';
  static const String reflow = 'assets/images/comm.png';
  static const String signUp = 'assets/images/up.png';
  static const String login = 'assets/images/login.png';
  static const String profile = 'assets/images/profile.png';
  static const String welcome = 'assets/images/welcome.png';
  static const String outgoingCall = 'sounds/outgoing_call.mp3';
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

const appId = '3aea6f71bc31497cbd3e3dcdaf28a644';

const testToken =
    '007eJxTYFhUFmivMun4k0rPZY7zlG9xxLRV7+K8ciJd5U5QgXao0kQFBoukpLREA5MkE+MUQxMDY0uLZDMTs7RUCzODVHNzw+REi/RzyQ2BjAydOpLMjAwQCOKzMqTllJaUMDAAAP7bHew=+GSRTKfHR+dXmrnN7hK7Mmq/T19zcrMFgkJaUlGpgkmRinGJoYGFtaJJuZmKWlWpgZpJqbGyYnXlc8mdwQyMiwdsN8RkYGCATxWRnSckpLShgYAK5pITE=';

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

enum Search {
  searching,
  found,
  noMatch,
  finishSearch,
}

class CustomIcons {
  static const String checkbox = 'assets/icons/check.png';
  static const String photo = 'assets/icons/photo.png';
  static const String sendMessage = 'assets/icons/send_message_icon.png';
  static const String attachMessage = 'assets/icons/attach_message_icon.png';
}
