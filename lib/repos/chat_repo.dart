
import 'package:ciel_ai/model/chat_message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CielRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessage) async {
    try {
      Dio dio = Dio();
     

      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${dotenv.env['apiKey']}",
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
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data["candidates"].first["content"]["parts"].first["text"];
      }
      return "";
    } catch (e) {
      print(e.toString());
      return "";
    }
  }
}
