import 'package:flutter/material.dart';
import 'package:frontend/constants/network_req_state.dart';
import 'package:frontend/constants/route_names.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repository/user_repository.dart';
import 'package:frontend/services/auth_service/auth_service.dart';
import 'package:frontend/services/navigation/navigation_service.dart';

/// Abstract interface for ViewModel of Profile Screen
abstract class IProfileViewModel extends ChangeNotifier {
  /// False untill user data is loaded,
  /// Set to true once user data is loaded
  /// Widgets are notifed when the value change
  NetworkReqState get isDataLoaded;

  /// User object which holds User data, this will contain:
  ///  - userName
  ///  - bio
  ///  - phoneNumber
  ///  - age
  ///  - gender
  User? get user;

  /// A [TextEditingController] for bio [TextField]
  late final TextEditingController bioController;

  /// Load user profile data from Remote
  Future<void> loadUserProfileData();

  /// Add an interest to User
  /// Takes a [String] interest as an argument
  /// and adds it to [User] if maximum interest limit is not reached.
  void addInterest(String interest) {}

  /// Opens a dialoge to add a user interest
  void openAddInterestDialog() {}

  /// Gets User's profile logged out
  void logoutHandle() {}

  /// Navigate back to screen
  void goBack();
}

class ProfileViewModel extends ChangeNotifier implements IProfileViewModel {
  ProfileViewModel(this._navigationService, this._userRepository) {
    /// This ensures User Data is pre loaded at creation of instance
    /// of this class so [_user] is not null
    loadUserProfileData();
  }

  NetworkReqState _isDataLoaded = NetworkReqState.notLoaded;
  @override
  NetworkReqState get isDataLoaded => _isDataLoaded;

  final NavigationService _navigationService;

  final IUserRepository _userRepository;

  User? _user;
  @override
  User? get user => _user;

  @override
  TextEditingController bioController = TextEditingController();

  @override
  Future<void> loadUserProfileData() async {
    // First load data from local storage
    _isDataLoaded = NetworkReqState.loading;
    notifyListeners();
    try {
      _user = await _userRepository.getLocalUserData();
      notifyListeners();
      var remote = await _userRepository.getRemoteUserData();
      if (remote != _user) {
        _user = remote;
        _userRepository.saveUserDataLocal(remote);
        notifyListeners();
      }
      _isDataLoaded = NetworkReqState.loaded;
    } catch (e) {
      _isDataLoaded = NetworkReqState.error;
      notifyListeners();
    }
  }

  @override
  void addInterest(String interest) {
    /// Check if more interests can be added. Max limit is 6
    if (_user!.interests.length < 6) {
      _user = _user!.copyWith(interests: [..._user!.interests, interest]);
    }
  }

  @override
  void openAddInterestDialog() {}

  @override
  void logoutHandle() async {
    await AuthService().signOut();
    notifyListeners();
    _navigationService.go(RouteNames.login);
  }

  @override
  void goBack() {
    _navigationService.pop();
  }
}
