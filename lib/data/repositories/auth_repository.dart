import 'package:firebase_auth/firebase_auth.dart';
import 'package:tadbiroemas_78/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository({
    required FirebaseAuthService firebaseAuthService,
  }) : _firebaseAuthService = firebaseAuthService;

  Future<void> login(String email, String password) async {
    await _firebaseAuthService.login(email, password);
  }

  Future<void> register(String email, String password) async {
    await _firebaseAuthService.register(email, password);
  }

  Future<void> logout() async {
    await _firebaseAuthService.logout();
  }

  Stream<User?> get userState {
    return _firebaseAuthService.userState;
  }

  User? get currentUser {
    return _firebaseAuthService.currentUser;
  }
}
