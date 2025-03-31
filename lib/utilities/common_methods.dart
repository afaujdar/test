
String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}


String capitalizeEachWord(String text) {
  return text.split(' ').map((word) => capitalize(word)).join(' ');
}
