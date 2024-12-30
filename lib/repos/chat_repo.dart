import 'dart:ffi';
import 'dart:math';

import 'package:ciel_ai/const.dart';
import 'package:ciel_ai/model/chat_message_model.dart';
import 'package:dio/dio.dart';

class CielRepo {
  static chatTextGenerationRepo(List<ChatMessageModel> previousMessage) async {
    try {
      Dio dio = Dio();

      final response = dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${apiKey}",
          data: {
            "contents": previousMessage.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 1,
              "topK": 40,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "responseMimeType": "text/plain"
            }
          });
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
