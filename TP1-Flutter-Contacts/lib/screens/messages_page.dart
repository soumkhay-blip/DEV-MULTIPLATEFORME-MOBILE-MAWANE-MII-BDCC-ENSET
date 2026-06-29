import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/contact.dart';
import '../models/message.dart';
import '../services/api_service.dart';

class MessagesPage extends StatefulWidget {
  final Contact contact;

  const MessagesPage({super.key, required this.contact});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  List<Message> _messages = [];
  bool _loading = true;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final messages = await ApiService.getMessages(widget.contact.id);
      if (!mounted) return;
      setState(() {
        _messages = messages;
        _loading = false;
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '$e';
        _loading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) return;

    setState(() => _sending = true);
    try {
      final sent = await ApiService.sendMessage(widget.contact.id, text);
      if (!mounted) return;
      setState(() {
        _messages.add(sent);
        _controller.clear();
      });
      _scrollToBottom();
    } catch (e) {
      _showSnack('Échec de l\'envoi : $e');
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _reply() async {
    final reply = await ApiService.sendReply(
      widget.contact.id,
      'Réponse de ${widget.contact.name} 👋',
    );
    if (!mounted) return;
    setState(() => _messages.add(reply));
    _scrollToBottom();
  }

  void _showSnack(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.contact.profile),
              onBackgroundImageError: (_, _) {},
            ),
            const SizedBox(width: 12),
            Text(widget.contact.name),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Simuler une réponse',
            icon: const Icon(Icons.reply),
            onPressed: _reply,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody()),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _loadMessages,
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      );
    }
    if (_messages.isEmpty) {
      return const Center(child: Text('Aucun message. Démarrez la conversation !'));
    }
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: _messages.length,
      itemBuilder: (context, index) => _MessageBubble(message: _messages[index]),
    );
  }

  Widget _buildComposer() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: 'Votre message…',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              onPressed: _sending ? null : _send,
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              elevation: 0,
              child: _sending
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Message message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSent;
    final time = DateFormat('dd/MM HH:mm').format(message.dateTime);

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isSent ? Colors.deepOrange : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isSent ? 16 : 2),
            bottomRight: Radius.circular(isSent ? 2 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: isSent ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isSent ? Colors.white70 : Colors.black54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
