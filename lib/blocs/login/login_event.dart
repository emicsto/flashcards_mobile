import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {}
