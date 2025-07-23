import 'package:flutter/material.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/services/user_registration/register_repo.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel(this._navService);

  /// NavigationService instance for accessing navigation
  final NavigationService _navService;

  /// Private fields to hold the data
  String _username = '';
  String _bio = '';
  String _gender = '';
  List<String> _interests = [];
  final int _coins = 0;
  //TODO: Change the default profile picture to include path of user's profile picture
  String _profilePicture = 'https://exampleimgurl.com/testpic.jpg';
  String _birthdate = '';
  //TODO: Get the phone number from the user
  final String _phoneNumber = "1234567890";

  // Public getters to access the data from the UI
  String get username => _username;
  String get bio => _bio;
  String get gender => _gender;
  List<String> get interests => _interests;
  int get coins => _coins;
  String get phoneNumber => _phoneNumber;
  String get birthdate => _birthdate;

  // Setters to update the data
  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setBio(String value) {
    _bio = value;
    notifyListeners();
  }

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  void setInterests(List<String> value) {
    _interests = value;
    notifyListeners();
  }

  void setProfilePicture(String value) {
    _profilePicture = value;
    notifyListeners();
  }

  void setBirthdate(String value) {
    _birthdate = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> submitProfile() async {
    _isLoading = true;
    notifyListeners();
    try {
      await RegisterRepo()
          .registerUser(
            username: _username,
            bio: _bio,
            gender: _gender,
            interests: _interests,
            coins: _coins,
            profilePicture: _profilePicture,
            phoneNumber: _phoneNumber,
            birthdate: _birthdate,
          )
          .then((val) {
            _isLoading = false;
            notifyListeners();

            ///TODO: Change the routing to role based
            if (gender == 'female') {
              _navService.go(RouteNames.creatorHome);
              return;
            }
            _navService.go(RouteNames.consumerHome);
          });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error during registration: $e');
    }
  }
}
