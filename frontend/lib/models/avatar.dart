/// Represents an image associated with a user profile.
class Avatar {
  final String id;
  final String url;

  Avatar({required this.id, required this.url});

  /// Creates an [Avatar] from a JSON map.
  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(id: json['id'] as String, url: json['url'] as String);
  }

  /// Converts this [Avatar] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url};
  }

  /// Creates a copy of this [Avatar] with optional new values.
  Avatar copyWith({String? id, String? url}) {
    return Avatar(id: id ?? this.id, url: url ?? this.url);
  }
}
