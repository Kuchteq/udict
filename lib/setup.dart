import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udict/dbaccess.dart';
import 'package:udict/leo_client_repository.dart';
import 'package:udict/linguee_response.dart';

import 'linguee_client_repository.dart';

final getIt = GetIt.instance;

class GlobalState {
  final currentDict = ValueNotifier(0);
  List<SavedTranslations> savedTrans = [];
}

class SavedTranslations {
  String source;
  Translation translation;
  SavedTranslations(this.source, this.translation);

  Future<void> saveTrans() async {
    int newEntryId = await localDb.insert("Saved", {"term": source});
    localDb.insert("Translation", {
      "featured": translation.featured,
      "text": translation.text,
      "pos": translation.pos,
      "saved_id": newEntryId
    });
        if (translation.examples != null) {
                  
    for (var i = 0; i < translation.examples!.length; i++) {
            localDb.insert("Example", {"src": translation.examples![i].src, "dst": translation.examples![i].dst, "translation_id": newEntryId});
    }
                }
    // await localDb.insert("Example",translation.examples![0].toJson());
  }

  static Future<List<SavedTranslations>> fetch() async {
    final List<Map<String, Object?>> savedMaps = await localDb.query("Saved", orderBy: "id DESC");
    List<SavedTranslations> saved = [];
    // This is slow as fuck but I am too lazy to optimize this for now
    for (var i = 0; i < savedMaps.length; i++) {
      final List<Map<String, Object?>> translations = await localDb.query("Translation",
          where: "saved_id = ?", whereArgs: [savedMaps[i]['id'] as int], limit:1);

      final List<Map<String, Object?>> examplesMaps = await localDb.query("Example",
          where: "translation_id = ?", whereArgs: [translations[0]['id'] as int]);
      List<Example> examples = [
        for (final {"src": src as String, "dst": dst as String} in examplesMaps)
          Example(src: src, dst: dst)
      ];
      saved.add(SavedTranslations(savedMaps[i]['term'] as String,
          Translation(text: translations[0]["text"] as String, examples: examples,  pos: translations[0]['pos'] as String)));
    }
    return saved;
  }
}

void setupGetIt() {
  // state management layer

  getIt.registerLazySingleton<GlobalState>(() => GlobalState());
  getIt.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>());
  getIt.registerLazySingleton<LingueeClientRepository>(() => LingueeClientRepository());
  getIt.registerLazySingleton<LeoClientRepository>(() => LeoClientRepository());
}

Future<void> registerDatabase() async {
  final localDb = await DbAccess().db;
  getIt.registerSingleton<Database>(localDb);
}

/* Creating a global shortcut for local sqlite database
 Losing on some of the transparency in the classes that use it 
 but it helps with reducing boilerplate code. Before contributing,
 please make sure you are acquainted with the minimal_contributing_guide.md
 quickstart guide where things like this are explained.
 */
Database get localDb => getIt.get<Database>();
