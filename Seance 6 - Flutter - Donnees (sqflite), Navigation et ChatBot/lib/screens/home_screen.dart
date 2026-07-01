import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'login_screen.dart';
import 'navigation_demo.dart';
import 'users_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final parties = <Map<String, dynamic>>[
      {
        'titre': 'Activité 1 : CRUD sqflite',
        'icone': Icons.storage,
        'ecran': const UsersScreen(),
      },
      {
        'titre': 'Activité 2 : Navigation',
        'icone': Icons.swap_horiz,
        'ecran': const FirstRoute(),
      },
      {
        'titre': 'Projet : ChatBot ChatGPT',
        'icone': Icons.smart_toy,
        'ecran': const ChatScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter P3 - Données & UI'),
        actions: [
          IconButton(
            tooltip: 'Thème clair/sombre',
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
          ),
          IconButton(
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout),
            onPressed: () => _deconnexion(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < parties.length; i++)
              _CarteAnimee(
                delai: Duration(milliseconds: 150 * i),
                titre: parties[i]['titre'] as String,
                icone: parties[i]['icone'] as IconData,
                onTap: () => _ouvrir(context, parties[i]['ecran'] as Widget),
              ),
          ],
        ),
      ),
    );
  }

  void _ouvrir(BuildContext context, Widget ecran) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, _, _) => ecran,
        transitionsBuilder: (_, animation, _, child) {
          final decale = Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: decale, child: child),
          );
        },
      ),
    );
  }

  void _deconnexion(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen(onToggleTheme: onToggleTheme)),
    );
  }
}

class _CarteAnimee extends StatelessWidget {
  final Duration delai;
  final String titre;
  final IconData icone;
  final VoidCallback onTap;

  const _CarteAnimee({
    required this.delai,
    required this.titre,
    required this.icone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, valeur, child) {
        return Opacity(
          opacity: valeur,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - valeur)),
            child: child,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(icone, size: 32, color: Colors.indigo),
          title: Text(titre, style: const TextStyle(fontSize: 18)),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
