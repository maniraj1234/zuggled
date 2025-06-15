/// Represents an image associated with a user profile.
class Avatar {
  final String id;
  final String url;
  final int order;
  final String? caption; // Optional caption for the image

  Avatar({
    required this.id,
    required this.url,
    required this.order,
    this.caption,
  });

  /// Creates an [Avatar] from a JSON map.
  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'] as String,
      url: json['url'] as String,
      order: json['order'] as int,
      caption: json['caption'] as String?,
    );
  }

  /// Converts this [Avatar] to a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'url': url, 'order': order, 'caption': caption};
  }

  /// Creates a copy of this [Avatar] with optional new values.
  Avatar copyWith({String? id, String? url, int? order, String? caption}) {
    return Avatar(
      id: id ?? this.id,
      url: url ?? this.url,
      order: order ?? this.order,
      caption: caption ?? this.caption,
    );
  }
}
