// An domain object
class LingueeResponse {
  bool? featured;
  String? text;
  String? pos;
  List<dynamic>? forms;
  String? grammarInfo;
  List<AudioLinks>? audioLinks;
  List<Translation>? translations;

  LingueeResponse(
      {this.featured,
      this.text,
      this.pos,
      this.forms,
      this.grammarInfo,
      this.audioLinks,
      this.translations});

  LingueeResponse.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    text = json['text'];
    pos = json['pos'];
    forms = json['forms'];
    grammarInfo = json['grammar_info'];
    if (json['audio_links'] != null) {
      audioLinks = <AudioLinks>[];
      json['audio_links'].forEach((v) {
        audioLinks!.add(AudioLinks.fromJson(v));
      });
    }
    if (json['translations'] != null) {
      translations = <Translation>[];
      json['translations'].forEach((v) {
        translations!.add(Translation.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['featured'] = this.featured;
  //   data['text'] = this.text;
  //   data['pos'] = this.pos;
  //   if (this.forms != null) {
  //     data['forms'] = this.forms!.map((v) => v.toJson()).toList();
  //   }
  //   data['grammar_info'] = this.grammarInfo;
  //   if (this.audioLinks != null) {
  //     data['audio_links'] = this.audioLinks!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.translations != null) {
  //     data['translations'] = this.translations!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class AudioLinks {
  String? url;
  String? lang;

  AudioLinks({this.url, this.lang});

  AudioLinks.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['lang'] = lang;
    return data;
  }
}

class Translation {
  bool? featured;
  String? text;
  String? pos;
  List<AudioLinks>? audioLinks;
  List<Example>? examples;
  void usageFrequency;

  Translation(
      {this.featured,
      this.text,
      this.pos,
      this.audioLinks,
      this.examples,
      this.usageFrequency});

  Translation.fromJson(Map<String, dynamic> json) {
    featured = json['featured'];
    text = json['text'];
    pos = json['pos'];
    if (json['audio_links'] != null) {
      audioLinks = <AudioLinks>[];
      json['audio_links'].forEach((v) {
        audioLinks!.add(AudioLinks.fromJson(v));
      });
    }
    if (json['examples'] != null) {
      examples = <Example>[];
      json['examples'].forEach((v) {
        examples!.add(Example.fromJson(v));
      });
    }
    usageFrequency = json['usage_frequency'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['featured'] = this.featured;
  //   data['text'] = this.text;
  //   data['pos'] = this.pos;
  //   if (this.audioLinks != null) {
  //     data['audio_links'] = this.audioLinks!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.examples != null) {
  //     data['examples'] = this.examples!.map((v) => v.toJson()).toList();
  //   }
  //   data['usage_frequency'] = this.usageFrequency;
  //   return data;
  // }
}

class Example {
  final String src;
  final String dst;

  Example({required this.src, required this.dst});

  factory Example.fromJson(Map<String, dynamic> json) {
    return Example(src: json['src'], dst: json['dst']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['dst'] = dst;
    return data;
  }
}
