import 'dart:convert';
import 'dart:ui';

import 'package:edupals/core/base/model/user.dart';
import 'package:edupals/core/services/secure_storage_service.dart';
import 'package:edupals/core/values/app_strings.dart';
import 'package:edupals/features/dashboard/domain/model/curriculum.dart';
import 'package:flutter/material.dart';

class LocalRepository {
  final SecureStorageService secureStorageService = SecureStorageService();

  final String accessTokenKey = AppStrings.storageAccessToken;
  final String languageKey = AppStrings.storageLanguage;
  final String user = AppStrings.storageUser;
  final String curriculum = "curriculum";

  Future<void> clearStorage() async {
    await Future.wait([
      secureStorageService.delete(accessTokenKey),
      secureStorageService.delete(curriculum),
      secureStorageService.delete(user)
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
    final storageUser = await secureStorageService.getString(user) ?? "";
    return storageUser.isEmpty == true
        ? null
        : User.fromJson(jsonDecode(storageUser));
  }

  Future<Curriculum?> getCurriculum() async {
    final storageCurriculum =
        await secureStorageService.getString(curriculum) ?? "";
    return storageCurriculum.isEmpty == true
        ? null
        : Curriculum.fromJson(jsonDecode(storageCurriculum));
  }

  Future<void> setUser(String? value) async {
    return await secureStorageService.setString(user, value ?? '');
  }

  Future<void> setCurriculum(String? value) async {
    return await secureStorageService.setString(curriculum, value ?? '');
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
