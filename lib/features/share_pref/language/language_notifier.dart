import 'package:flutter/material.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageNotifier extends StateNotifier<Locale> {

  static const _key = 'app_language';

  LanguageNotifier() : super(const Locale('en')) {
    _loadSaved();
  }

  /// 🔄 APP START → LOAD SAVED LANGUAGE
  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'en';
    state = Locale(code);
  }

  /// 🌍 CHANGE LANGUAGE
  Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
    state = Locale(code);
  }
}

final languageProvider =
StateNotifierProvider<LanguageNotifier, Locale>(
      (ref) => LanguageNotifier(),
);
