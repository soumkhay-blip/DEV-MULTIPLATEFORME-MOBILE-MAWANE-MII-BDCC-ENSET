import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/navigation_demo.dart';
import 'screens/users_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter P3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter P3 - Données & UI')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Carte(
              titre: 'Activité 1 : CRUD sqflite',
              icone: Icons.storage,
              onTap: () => _ouvrir(context, const UsersScreen()),
            ),
            _Carte(
              titre: 'Activité 2 : Navigation',
              icone: Icons.swap_horiz,
              onTap: () => _ouvrir(context, const FirstRoute()),
            ),
            _Carte(
              titre: 'Projet : ChatBot ChatGPT',
              icone: Icons.smart_toy,
              onTap: () => _ouvrir(context, const ChatScreen()),
            ),
          ],
        ),
      ),
    );
  }

  void _ouvrir(BuildContext context, Widget ecran) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ecran));
  }
}

class _Carte extends StatelessWidget {
  final String titre;
  final IconData icone;
  final VoidCallback onTap;

  const _Carte({required this.titre, required this.icone, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icone, size: 32, color: Colors.indigo),
        title: Text(titre, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
