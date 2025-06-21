import 'package:frontend/constants/enums.dart';
import 'package:frontend/models/avatar.dart';

/// Represents a user profile for a Creator.
class Creator {
  final String id;
  final String userName;
  final Gender gender;
  final String? bio;
  final Avatar profilePicture;
  final List<String> interests;
  final bool isLiked;
  final bool videoCallAvailable;
  final bool audioCallAvailable;

  Creator({
    required this.id,
    required this.userName,
    required this.gender,
    this.bio,
    required this.profilePicture,
    required this.interests,
    required this.isLiked,
    required this.videoCallAvailable,
    required this.audioCallAvailable,
  });

  /// Creates a [Creator] from a JSON map.
  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'] as String,
      userName: json['userName'] as String,
      gender: Gender.values.firstWhere(
        (e) => e.toString() == 'Gender.${json['gender']}',
      ),
      bio: json['bio'] as String?,
      profilePicture: Avatar.fromJson(
        json['profilePicture'] as Map<String, dynamic>,
      ),
      interests:
          (json['interests'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
      isLiked: json['isLiked'] as bool,
      videoCallAvailable: json['videoCallAvailable'] as bool,
      audioCallAvailable: json['audioCallAvailable'] as bool,
    );
  }

  /// Converts this [Creator] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'gender': gender.toString().split('.').last,
      'bio': bio,
      'profilePicture': profilePicture.toJson(),
      'interests': interests,
      'isLiked': isLiked,
      'videoCallAvailable': videoCallAvailable,
      'audioCallAvailable': audioCallAvailable,
    };
  }

  /// Creates a copy of this [Creator] with optional new values.
  Creator copyWith({
    String? id,
    String? userName,
    Gender? gender,
    String? bio,
    Avatar? profilePicture,
    List<String>? interests,
    bool? isLiked,
    bool? videoCallAvailable,
    bool? audioCallAvailable,
  }) {
    return Creator(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      profilePicture: profilePicture ?? this.profilePicture,
      interests: interests ?? this.interests,
      isLiked: isLiked ?? this.isLiked,
      videoCallAvailable: videoCallAvailable ?? this.videoCallAvailable,
      audioCallAvailable: audioCallAvailable ?? this.audioCallAvailable,
    );
  }
}
