import 'dart:convert';
import 'dart:ui';

import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/services/secure_storage_service.dart';
import 'package:edupals/core/values/app_strings.dart';

class LocalRepository {
  final SecureStorageService secureStorageService = SecureStorageService();

  final String accessTokenKey = AppStrings.storageAccessToken;
  final String languageKey = AppStrings.storageLanguage;
  final String user = AppStrings.storageUser;

  Future<void> clearStorage() async {
    await Future.wait([
      secureStorageService.delete(accessTokenKey),
    ]);
  }

  Future<String?> getAccessToken() async {
    return await secureStorageService.getString(accessTokenKey);
  }

  Future<Locale?> getLanguage() async {
    final String? localeString =
        await secureStorageService.getString(languageKey);

    return localeString?.isNotEmpty == true
        ? Locale(localeString!.split('-')[0], localeString.split('-')[1])
        : null;
  }

  Future<User?> getUser() async {
    return User.fromJson(
        jsonDecode(await secureStorageService.getString(user) ?? ""));
  }

  Future<void> setUser(String? value) async {
    return await secureStorageService.setString(user, value ?? '');
  }

  Future<void> setAccessToken(String? accessToken) async {
    return await secureStorageService.setString(
        accessTokenKey, accessToken ?? '');
  }

  Future<void> setLanguage(Locale locale) async {
    final String localeString = locale.toLanguageTag();

    return await secureStorageService.setString(languageKey, localeString);
  }
}
