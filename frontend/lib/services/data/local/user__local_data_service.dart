import 'package:frontend/constants/enums.dart';
import 'package:frontend/models/user.dart';

abstract class IUserLocalDataService {
  /// Get User data from local Storage
  Future<User> getUserData();

  /// Save User data to local Storage
  /// If data exists, it updates the existing User data
  /// If it doesn't exist, it will create new User data
  Future<void> saveUserData(User user);
}

class MockUserLocalDataService implements IUserLocalDataService {
  @override
  Future<void> saveUserData(User user) async {
    /// TODO:Implement function to saving User data if changed
  }

  @override
  Future<User> getUserData() async {
    // Mimic delay to retrieve data from local storage
    await Future.delayed(Duration(milliseconds: 20));

    return (User(
      userID: "user_m_1",
      userName: "alex_tech_wiz",
      bio:
          "Avid traveler and outdoor enthusiast. Always looking for the next mountain to climb or trail.",
      profilePicture: "lib/assets/images/placeholder.png",
      gender: Gender.male,
      birthDate: DateTime(2002, 4, 23),
      phoneNumber: "+866890123457",
      interests: ["coding", "AI", "gadgets", "cybersecurity"],
    ));
  }
}
