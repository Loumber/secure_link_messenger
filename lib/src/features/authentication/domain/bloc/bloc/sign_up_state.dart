part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState{}

final class SignUpLoading extends SignUpState{}

final class SignUpEmailVerify extends SignUpState{}

final class IsSignUp extends SignUpState{}

final class SignUpError extends SignUpState{}