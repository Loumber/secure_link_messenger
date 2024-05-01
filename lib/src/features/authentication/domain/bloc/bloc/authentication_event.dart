part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

//class GoAuthenticationEvent extends AuthenticationEvent{}

class IsSignUpEvent extends AuthenticationEvent{}

class GoSignUpEvent extends AuthenticationEvent{}

class SignUpLoadingDataEvent extends AuthenticationEvent{
  final File photo;
  final String email;
  final String name;
  final String password;

  SignUpLoadingDataEvent({required this.photo, required this.email, required this.name, required this.password});
}

class SignInLoadingDataEvent extends AuthenticationEvent{
  final String email;
  final String password;

  SignInLoadingDataEvent({required this.email, required this.password});
}


class SignUpLoadedDataEvent extends AuthenticationEvent{}

class ErrorSignUp extends AuthenticationEvent{}

class GoSignInEvent extends AuthenticationEvent{}