import 'dart:async';

import 'package:hive/hive.dart';

import '../constant.dart';


mixin UserPreferences {
  static Future<void> openAllStorageBoxes() async {
    await Hive.openBox<dynamic>(Constants.userPreferencesBox);
  }

  static Box<dynamic> get _userPreferencesBox =>
      Hive.box<dynamic>(Constants.userPreferencesBox);

  void putInUserPreferences(
      {required String key, required dynamic value}) async {
    await _userPreferencesBox.put(key, value);
  }

  void putAllInUserPreferences(
      {required Map<String, dynamic> mapOfKeysToValues}) async {
    await _userPreferencesBox.putAll(mapOfKeysToValues);
  }

  dynamic getFromUserPreference({required String key}) {
    _userPreferencesBox.get(key);
  }

  static Future<void> clearUserPreferences() async {
    _userPreferencesBox.clear();
  }
}
