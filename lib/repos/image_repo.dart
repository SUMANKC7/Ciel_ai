import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageRepo {
  static Future<Uint8List?> generateImage(String prompt) async {
    try {
      String url = "https://api.vyro.ai/v2/image/generations";
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer ${dotenv.env['imgapikey']}',
      };

      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style': 'anime',
        'aspect_ratio': '1:1',
        'seed': '5',
        'max_generations': '1',
      };
      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options =
          BaseOptions(headers: headers, responseType: ResponseType.bytes);

      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        log(response.data.runtimeType.toString());
        log(response.data.toString());
        Uint8List uint8list = Uint8List.fromList(response.data);
        return uint8list;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
