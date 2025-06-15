import 'package:frontend/constants/enums.dart';
import 'package:frontend/models/avatar.dart';

/// Represents a user's profile in the dating app.
class User {
  final String userID;
  final String userName;
  final Avatar avatar;
  final String? bio;
  final Gender gender;
  final List<String> interests;
  final String? phoneNumber;

  User({
    required this.userID,
    required this.userName,
    required this.avatar,
    this.bio,
    required this.gender,
    required this.interests,
    this.phoneNumber,
  });

  /// Creates a [User] from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'] as String,
      userName: json['userName'] as String,
      avatar: Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      bio: json['bio'] as String?,
      gender: Gender.values.firstWhere(
        (e) => e.toString() == 'Gender.${json['gender']}',
      ),
      interests:
          (json['interests'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
      phoneNumber: json['phoneNumber'] as String?,
    );
  }

  /// Converts this [User] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'userName': userName,
      'avatar': avatar.toJson(),
      'bio': bio,
      'gender': gender.toString().split('.').last,
      'interests': interests,
      'phoneNumber': phoneNumber,
    };
  }

  /// Creates a copy of this [User] with optional new values.
  User copyWith({
    String? userID,
    String? userName,
    Avatar? avatar,
    String? bio,
    Gender? gender,
    List<String>? interests,
    String? phoneNumber,
  }) {
    return User(
      userID: userID ?? this.userID,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      interests: interests ?? this.interests,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
