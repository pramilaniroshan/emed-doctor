import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeService {
  late SharedPreferences prefs;
  final _key = 'isDarkMode';

  
  /// Get isDarkMode info from local storage and return ThemeMode
  //ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  
  
  /// Switch theme and save to local storage
  void switchTheme() {
    
      /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => prefs.getBool(_key) ?? false;
  
  
  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => prefs.setBool(_key, isDarkMode);
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}