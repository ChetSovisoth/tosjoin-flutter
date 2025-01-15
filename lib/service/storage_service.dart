// storage_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const String _token = 'token';
const String _profile = 'profile';
const String _tokenId = 'token_id';
const String _language = 'language';
const String _theme = 'theme';
const String _baseUrl = 'https://tosjoin-367404119922.asia-southeast1.run.app';

class StorageService extends GetxService {
  final _box = GetStorage();
  final _loggedIn = RxBool(false);

  @override
  Future<void> onInit() async {
    _loggedIn.value = token != null;
    if (!_loggedIn.value) {
      await _box.erase();
    }
    super.onInit();
  }

  String? get token => _box.read(_token);

  Future<void> setBaseUrl(String url) async {
    await _box.write(_baseUrl, url);
  }

  Future<void> setProfile(Map<String, dynamic> profile) async {
    print(profile);
    await _box.write(_profile, profile);
  }

  // Token
  Future<void> setToken(String token) async {
    await _box.write(_token, token);
    _loggedIn.value = true;
  }

  Future<void> setRefreshToken(String token) async {
    await _box.write(_token, token);
  }

  Future<void> setTokenId(String tokenId) async {
    await _box.write(_tokenId, tokenId);
    _loggedIn.value = true;
  }

  Future<void> setLogout() async {
    await _box.remove(_token);
    await _box.remove(_profile);
    _loggedIn.value = false;
  }

  // Language
  Locale getLocal() {
    final localeData = _box.read(_language);
    if (localeData == null ||
        localeData['code'] == null ||
        localeData['country'] == null) {
      return const Locale('kh', 'CM'); // Default locale
    }
    return Locale(localeData['code'], localeData['country']);
  }

  Future<void> setLocale({required Locale language}) async {
    final map = {
      "code": language.languageCode,
      "country": language.countryCode,
    };
    await _box.write(_language, map);
  }

  ThemeMode getTheme() {
    final myTheme = _box.read(_theme);
    switch (myTheme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  String get getThemeName => _box.read(_theme) ?? "system";
  Future<void> setTheme({required ThemeMode mode}) async {
    switch (mode) {
      case ThemeMode.light:
        await _box.write(_theme, 'light');
      case ThemeMode.dark:
        await _box.write(_theme, 'dark');
      default:
        await _box.write(_theme, 'system');
    }
  }
}
