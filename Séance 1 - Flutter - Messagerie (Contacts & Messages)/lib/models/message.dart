class Message {
  final int? id;
  final int contactID;
  final DateTime dateTime;
  final String type;
  final String message;

  Message({
    this.id,
    required this.contactID,
    required this.dateTime,
    required this.type,
    required this.message,
  });

  bool get isSent => type == 'sent';

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int?,
      contactID: (json['contactID'] as num).toInt(),
      dateTime: DateTime.parse(json['date'] as String),
      type: json['type'] as String? ?? 'sent',
      message: json['message'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'contactID': contactID,
        'message': message,
        'type': type,
        'date': dateTime.toString(),
      };
}
