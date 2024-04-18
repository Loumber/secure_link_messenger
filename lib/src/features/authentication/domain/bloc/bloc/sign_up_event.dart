part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}


class IsSignUpEvent extends SignUpEvent{}

class LoadingDataEvent extends SignUpEvent{}

class LoadedDataEvent extends SignUpEvent{}

class ErrorSignUp extends SignUpEvent{}
