import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:vocadb/bloc/bloc.dart';
import 'package:vocadb/models/user_model.dart';
import 'package:vocadb/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final UserModel userModel = await userRepository.getCurrent();

      if (userModel != null) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
//      yield AuthLoading();
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
//      await userRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}