part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState{}

final class SignUpInitial extends AuthenticationState{}

final class SignInInitial extends AuthenticationState{}

final class SignUpLoading extends AuthenticationState{}

final class SignInLoading extends AuthenticationState{}

final class SignUpEmailVerify extends AuthenticationState{}

final class IsAuthentication extends AuthenticationState{}

final class SignUpError extends AuthenticationState{}