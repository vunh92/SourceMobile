extension StringHelper on String {
  bool checkValidPhoneNumber() {
    const patent =
        r'^(?:\+84|0|84)?(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$';
    return RegExp(patent).hasMatch(replaceAllSpace());
  }

  String replaceAllSpace() {
    return split(' ').join();
  }
}
