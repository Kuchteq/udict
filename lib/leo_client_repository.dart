import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udict/leo_response.dart';

class LeoClientRepository {
  String? currentQuery = "";
  ValueNotifier<String?> server = ValueNotifier("https://example.com/leo");

  ValueNotifier<ClientState> state = ValueNotifier<ClientState>(ClientState.start);
  StreamController<List<LeoResponseSection>> termStream = StreamController();

  void fetchTerm(String query) async {
    List<LeoResponseSection>responses = [];
    // jsonDecode(val).forEach((k,v) {
    //         responses.add(LeoResponseSection.fromJson(v));
    // });
    state.value = ClientState.load;
    final response = await http.get(Uri.parse(
        '${server.value}/query?q=$query'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      jsonDecode(utf8.decode(response.bodyBytes)).forEach((k,v) {
        responses.add(LeoResponseSection.fromJson(v));
      });
      termStream.sink.add(responses);
      state.value = ClientState.done;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      termStream.sink.addError(ErrorTypes.lingueeBlock);
      state.value = ClientState.done;
      throw Exception('Stupid Linguee blocking requests');
     }
  }
}

enum ClientState {
  start,
  load,
  done,
}

enum ErrorTypes { lingueeBlock, noResults }
