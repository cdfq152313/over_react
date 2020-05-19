import 'package:over_react/over_react.dart';

autoKey(children) {
  if (children is List) {
    for (var i = 0; i < children.length; ++i) {
      final child = children[i];
      if (!(child is ReactElement && child.key != null)) {
        children[i] = (Fragment()..key = i)(child);
      }
    }
  }
  return children;
}
