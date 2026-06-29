import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/contact.dart';
import '../models/message.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  static Future<bool> login(String username, String password) async {
    final uri = Uri.parse(
      '$baseUrl/users?username=$username&password=$password',
    );
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Erreur serveur (${resp.statusCode})');
    }
    final List<dynamic> users = json.decode(resp.body) as List<dynamic>;
    return users.isNotEmpty;
  }

  static Future<List<Contact>> getContacts({String? type}) async {
    final query = (type == null || type.isEmpty) ? '' : '?type=$type';
    final uri = Uri.parse('$baseUrl/contacts$query');
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Impossible de charger les contacts (${resp.statusCode})');
    }
    final List<dynamic> data = json.decode(resp.body) as List<dynamic>;
    return data
        .map((e) => Contact.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Message>> getMessages(int contactID) async {
    final uri = Uri.parse('$baseUrl/messages?contactID=$contactID&_sort=date');
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Impossible de charger les messages (${resp.statusCode})');
    }
    final List<dynamic> data = json.decode(resp.body) as List<dynamic>;
    final messages = data
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList();
    messages.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return messages;
  }

  static Future<Message> sendMessage(int contactID, String text) async {
    final body = Message(
      contactID: contactID,
      dateTime: DateTime.now(),
      type: 'sent',
      message: text,
    ).toJson();

    final resp = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Échec de l\'envoi du message (${resp.statusCode})');
    }
    return Message.fromJson(json.decode(resp.body) as Map<String, dynamic>);
  }

  static Future<Message> sendReply(int contactID, String text) async {
    final body = Message(
      contactID: contactID,
      dateTime: DateTime.now(),
      type: 'received',
      message: text,
    ).toJson();

    final resp = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Échec de la réponse (${resp.statusCode})');
    }
    return Message.fromJson(json.decode(resp.body) as Map<String, dynamic>);
  }
}
