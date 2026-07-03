import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  static const String _apiKey = 'VOTRE_CLE_API_OPENAI';
  static const String _endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String> envoyer(String message) async {
    if (_apiKey == 'VOTRE_CLE_API_OPENAI') {
      return 'Configurez votre cle API OpenAI dans chat_service.dart pour activer le ChatBot.';
    }
    final reponse = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': message},
        ],
      }),
    );
    if (reponse.statusCode != 200) {
      throw Exception('Erreur API (${reponse.statusCode})');
    }
    final data = jsonDecode(utf8.decode(reponse.bodyBytes));
    return data['choices'][0]['message']['content'].toString().trim();
  }
}
