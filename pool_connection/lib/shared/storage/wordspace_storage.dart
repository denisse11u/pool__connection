import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pool_connection/models/wordspace_model.dart';

class WordspaceStorage {
  static AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<List<WordspaceModel>> getAllWordspaces() async {
    final jsonString = await storage.read(key: 'userData');
    if (jsonString == null) return [];

    final decoded = jsonDecode(jsonString) as List;
    return decoded.map((e) => WordspaceModel.fromJson(e)).toList();
  }

  Future<void> saveAllWordspaces(List<WordspaceModel> wordspaces) async {
    final jsonString = jsonEncode(wordspaces);
    await storage.write(key: 'userData', value: jsonString);
  }

  Future<void> addWordspace(WordspaceModel wordspace) async {
    List<WordspaceModel> wordspaces = await getAllWordspaces();
    wordspaces.add(wordspace);
    await saveAllWordspaces(wordspaces);
  }

  Future<void> updateWordspace(WordspaceModel updated) async {
    final list = await getAllWordspaces();
    final index = list.indexWhere((w) => w.id == updated.id);
    if (index == -1) return;

    list[index] = updated;
    await saveAllWordspaces(list);
  }

  Future<void> deleteWordspace(int wordspaceId) async {
    final list = await getAllWordspaces();
    list.removeWhere((w) => w.id == wordspaceId);
    await saveAllWordspaces(list);
  }

  Future<void> addCredential(int wordspaceId, Credential credential) async {
    final list = await getAllWordspaces();
    final index = list.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    final wordspace = list[index];
    final updated = WordspaceModel(
      id: wordspace.id,
      name: wordspace.name,
      description: wordspace.description,
      credentials: [...wordspace.credentials, credential],
    );

    list[index] = updated;
    await saveAllWordspaces(list);
  }

  Future<void> updateCredential(
    int wordspaceId,
    Credential updatedCredential,
  ) async {
    final list = await getAllWordspaces();
    final index = list.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    final wordspace = list[index];

    final updatedCredentials = wordspace.credentials
        .map((c) => c.id == updatedCredential.id ? updatedCredential : c)
        .toList();

    list[index] = WordspaceModel(
      id: wordspace.id,
      name: wordspace.name,
      description: wordspace.description,
      credentials: updatedCredentials,
    );

    await saveAllWordspaces(list);
  }

  Future<void> deleteCredential(int wordspaceId, int credentialId) async {
    final list = await getAllWordspaces();
    final index = list.indexWhere((w) => w.id == wordspaceId);
    if (index == -1) return;

    final wordspace = list[index];

    final updatedCredentials = wordspace.credentials
        .where((c) => c.id != credentialId)
        .toList();

    list[index] = WordspaceModel(
      id: wordspace.id,
      name: wordspace.name,
      description: wordspace.description,
      credentials: updatedCredentials,
    );

    await saveAllWordspaces(list);
  }
}
