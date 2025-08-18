import 'package:ciel_ai/model/chat_message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CielRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessage) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${dotenv.env['GEMINI_API_KEY']}",
        data: {
          "contents": previousMessage.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 1,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 1024,
          }
        },
      );

      if (response.statusCode == 200) {
        return response.data["candidates"][0]["content"]["parts"][0]["text"];
      }
      return "";
    } catch (e) {
      print(" Gemini API error: $e");
      return "";
    }
  }
}
