import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tadbiroemas_78/data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(InitialAuthState()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckUserStateEvent>(_onCheckUserState);
  }

  void _onRegister(RegisterEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await _authRepository.register(event.email, event.password);

      emit(LoggedInState(_authRepository.currentUser!));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _onLogin(LoginEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await _authRepository.login(event.email, event.password);

      emit(LoggedInState(_authRepository.currentUser!));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, emit) async {
    await _authRepository.logout();
    emit(LoggedOutState());
  }

  void _onCheckUserState(CheckUserStateEvent event, emit) async {
    if (_authRepository.currentUser == null) {
      emit(LoggedOutState());
    } else {
      emit(LoggedInState(_authRepository.currentUser!));
    }
  }
}
