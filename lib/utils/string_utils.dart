class StringUtils {
  static String format(String source, List<String> args) {
    String target = source;
    for (int i = 0; i < args.length; i++) {
      Pattern from = '{' + i.toString() + '}';
      target = target.replaceAll(from, args[i]);
    }
    return target;
  }

  static String truncate(String input, {int threshold}) {
    int t = threshold != null ? threshold : 10;
    if (input == null) {
      throw new ArgumentError("string: $input");
    }
    if (input.length == 0) {
      return input;
    }
    return input.length > t ? input.substring(0, t) + '..' : input;
  }

  static String capitalize(String input) {
    if (input == null) {
      throw new ArgumentError("string: $input");
    }
    if (input.length == 0) {
      return input;
    }
    List<String> l = input.split(' ');
    List<String> newList = <String>[];
    if (l.length == 1)
      return input[0].toUpperCase() + input.substring(1);
    if (l.length > 1) {
      l.forEach((st) {
        if (st != null && st != "")
          newList.add(st[0].toUpperCase() + st.substring(1));
      });
    }

    return newList.join(' ');
  }

  static String capitalizeSentence(String input){
    if (input == null) {
      throw new ArgumentError("string: $input");
    }
    if (input.length == 0) {
      return input;
    }

    var lower = input.toLowerCase();
    var firstLetter = lower.substring(0, 1).toUpperCase();
    return firstLetter + lower.substring(1, lower.length);
  }

}