class Contact {
  final int id;
  final String name;
  final String profile;
  final String type;
  final int score;

  Contact({
    required this.id,
    required this.name,
    required this.profile,
    required this.type,
    required this.score,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      profile: json['profile'] as String? ?? '',
      type: json['type'] as String? ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profile': profile,
        'type': type,
        'score': score,
      };
}
