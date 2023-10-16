class LeoResponseSection {
  final String id;
  final String display;
  final List<Translation> translations;

  LeoResponseSection({
    required this.id,
    required this.display,
    required this.translations,
  });

  factory LeoResponseSection.fromJson(Map<String, dynamic> json) {
    final List<dynamic> translationsJson = json['translations'];
    final List<Translation> translations = translationsJson
        .map((translationJson) => Translation.fromJson(translationJson))
        .toList();

    return LeoResponseSection(
      id: json['id'],
      display: json['display'],
      translations: translations,
    );
  }
}

class Translation {
  final String id;
  final String term;
  final String definition;

  Translation({
    required this.id,
    required this.term,
    required this.definition,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: json['id'],
      term: json['term'],
      definition: json['definition'],
    );
  }
}
