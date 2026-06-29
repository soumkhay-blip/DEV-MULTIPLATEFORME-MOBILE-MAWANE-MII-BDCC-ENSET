import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../services/api_service.dart';
import 'login_page.dart';
import 'messages_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  static const Map<String, String?> _filters = {
    'Tous': null,
    'Étudiants': 'Student',
    'Enseignants': 'Professor',
    'Développeurs': 'Developer',
  };

  String _selected = 'Tous';
  late Future<List<Contact>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.getContacts();
  }

  void _applyFilter(String label) {
    setState(() {
      _selected = label;
      _future = ApiService.getContacts(type: _filters[label]);
    });
  }

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  Color _colorForType(String type) {
    switch (type) {
      case 'Professor':
        return Colors.indigo;
      case 'Developer':
        return Colors.teal;
      case 'Student':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _labelForType(String type) {
    switch (type) {
      case 'Professor':
        return 'Enseignant';
      case 'Developer':
        return 'Développeur';
      case 'Student':
        return 'Étudiant';
      default:
        return type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: _filters.keys.map((label) {
                final selected = label == _selected;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 10),
                  child: ChoiceChip(
                    label: Text(label),
                    selected: selected,
                    onSelected: (_) => _applyFilter(label),
                    selectedColor: Colors.deepOrange,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<Contact>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return _ErrorView(
                    message: '${snapshot.error}',
                    onRetry: () => _applyFilter(_selected),
                  );
                }
                final contacts = snapshot.data ?? [];
                if (contacts.isEmpty) {
                  return const Center(child: Text('Aucun contact.'));
                }
                return RefreshIndicator(
                  onRefresh: () async => _applyFilter(_selected),
                  child: ListView.separated(
                    itemCount: contacts.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final c = contacts[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(c.profile),
                          onBackgroundImageError: (_, _) {},
                          child: c.profile.isEmpty
                              ? Text(c.name.isNotEmpty ? c.name[0] : '?')
                              : null,
                        ),
                        title: Text(c.name),
                        subtitle: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _colorForType(c.type)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _labelForType(c.type),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _colorForType(c.type),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('Score : ${c.score}',
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MessagesPage(contact: c),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
