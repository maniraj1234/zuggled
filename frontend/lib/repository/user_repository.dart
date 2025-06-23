import 'package:frontend/models/user.dart';
import 'package:frontend/services/data/local/user__local_data_service.dart';
import 'package:frontend/services/data/remote/user_remote_data_service.dart';

/// This class acts as abstract layer between FireStore
/// and ViewModels that will use User Data
abstract class IUserRepository {
  /// Get User data from remote database
  /// Return's [User] object after completion
  Future<User> getRemoteUserData();

  /// Get User data from local storage
  /// Use this when app is offline or
  /// when User data is needed instantly
  /// Return's [User] object after completion
  Future<User> getLocalUserData();

  /// Creates user both local and remote
  /// Use in Sign Up process
  /// Throws user alreaady exist error if user with
  /// user id already exists.
  Future<void> createUser(User user);

  /// saves user to local
  Future<void> saveUserDataLocal(User user);

  /// saves user to both local and remote
  Future<void> saveUserData(User user);
}

/// Testing User Repository, uses local files
class MockUserRepository implements IUserRepository {
  // Local Data service instance
  final IUserLocalDataService _localDataService;

  // Firestore service instance for Remote data
  final IUserRemoteDataService _remoteDataService;

  /// Get Single Instance
  MockUserRepository._(this._localDataService, this._remoteDataService);
  static MockUserRepository? _instance;
  factory MockUserRepository(
    IUserLocalDataService localService,
    IUserRemoteDataService remoteService,
  ) {
    _instance ??= MockUserRepository._(localService, remoteService);
    return _instance!;
  }
  @override
  Future<User> getRemoteUserData() async {
    return await _remoteDataService.getUserData();
  }

  @override
  Future<void> createUser(User user) async {
    _localDataService.saveUserData(user);
    _remoteDataService.createUser();
  }

  @override
  Future<void> saveUserDataLocal(User user) async {
    try {
      await _localDataService.saveUserData(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(User user) async {
    // Save User data to local storage
    _localDataService.saveUserData(user);
    // Save User data to remote
    _remoteDataService.updateUserData(user);
  }

  @override
  Future<User> getLocalUserData() async {
    try {
      User _user = await _localDataService.getUserData();
      return _user;
    } catch (e) {
      rethrow;
    }
  }
}
