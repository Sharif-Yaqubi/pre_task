
import 'package:flutter_riverpod/legacy.dart';

enum MainContentView {
  dashboard,
  settings,
}

final mainContentViewProvider = StateProvider<MainContentView>((ref) {
  return MainContentView.dashboard;
});
