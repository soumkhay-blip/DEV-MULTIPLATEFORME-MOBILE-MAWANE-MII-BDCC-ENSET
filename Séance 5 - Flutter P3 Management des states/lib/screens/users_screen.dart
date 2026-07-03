import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _db = DatabaseHelper.instance;
  List<User> _users = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _charger();
  }

  Future<void> _charger() async {
    setState(() => _loading = true);
    final liste = await _db.getUsers();
    if (!mounted) return;
    setState(() {
      _users = liste;
      _loading = false;
    });
  }

  Future<void> _ouvrirFormulaire({User? user}) async {
    final resultat = await showDialog<User>(
      context: context,
      builder: (_) => _UserDialog(user: user),
    );
    if (resultat == null) return;
    if (resultat.id == null) {
      await _db.insertUser(resultat);
    } else {
      await _db.updateUser(resultat);
    }
    await _charger();
  }

  Future<void> _supprimer(User user) async {
    final confirme = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Supprimer ${user.name} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    if (confirme == true && user.id != null) {
      await _db.deleteUser(user.id!);
      await _charger();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD sqflite - Users')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _ouvrirFormulaire(),
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
              ? const Center(child: Text('Aucun utilisateur. Ajoutez-en un.'))
              : ListView.separated(
                  itemCount: _users.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${user.age}')),
                      title: Text(user.name),
                      subtitle: Text('Age : ${user.age}'),
                      onTap: () => _ouvrirFormulaire(user: user),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _supprimer(user),
                      ),
                    );
                  },
                ),
    );
  }
}

class _UserDialog extends StatefulWidget {
  final User? user;
  const _UserDialog({this.user});

  @override
  State<_UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<_UserDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nom;
  late final TextEditingController _age;

  @override
  void initState() {
    super.initState();
    _nom = TextEditingController(text: widget.user?.name ?? '');
    _age = TextEditingController(text: widget.user?.age.toString() ?? '');
  }

  @override
  void dispose() {
    _nom.dispose();
    _age.dispose();
    super.dispose();
  }

  void _valider() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      User(
        id: widget.user?.id,
        name: _nom.text.trim(),
        age: int.parse(_age.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.user == null ? 'Nouvel utilisateur' : 'Modifier'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nom,
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nom obligatoire' : null,
            ),
            TextFormField(
              controller: _age,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Age obligatoire';
                if (int.tryParse(v.trim()) == null) return 'Age invalide';
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _valider, child: const Text('Enregistrer')),
      ],
    );
  }
}
