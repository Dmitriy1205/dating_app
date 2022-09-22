String? validateNameField(value) {
  if (value!.isEmpty) {
    return 'THIS FIELD CAN\'T BE EMPTY';
  }
  return null;
}

String? validatePhoneField(value) {
  if (value!.isEmpty) {
    return 'THIS FIELD CAN\'T BE EMPTY';
  }
  return null;
}

String? validateDateField(value) {
  if (value!.isEmpty) {
    return 'THIS FIELD CAN\'T BE EMPTY';
  }
  return null;
}

String? validateEmailField(value) {
  String pattern =
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'THIS FIELD CAN\'T BE EMPTY';
  }else if(!regex.hasMatch(value)){
    return 'ENTER A VALID EMAIL ADDRESS ';
  }
  return null;
}
