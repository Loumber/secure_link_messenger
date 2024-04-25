part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

//class GoAuthenticationEvent extends AuthenticationEvent{}

class IsSignUpEvent extends AuthenticationEvent{}

class GoSignUpEvent extends AuthenticationEvent{}

class SignUpLoadingDataEvent extends AuthenticationEvent{}

class SignUpLoadedDataEvent extends AuthenticationEvent{}

class ErrorSignUp extends AuthenticationEvent{}

class GoSignInEvent extends AuthenticationEvent{}