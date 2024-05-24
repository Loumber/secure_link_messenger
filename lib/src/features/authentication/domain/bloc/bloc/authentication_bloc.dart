import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:secure_link_messenger/src/app/di.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  AuthenticationBloc()
      : super(MyLocator.userRepository.isAuthorized
            ? IsAuthentication()
            : SignInInitial()) {
    on<GoSignInEvent>((event, emit) {
      emit(SignInInitial());
    });

    on<GoSignUpEvent>((event, emit) {
      emit(SignUpInitial());
    });

    on<SignOutEvent>((event, emit) async {
      emit(SignInInitial());
      await MyLocator.userRepository.signOut();
      logger.d('SignInInitial после выхода');
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(SignInInitial());
      await MyLocator.userRepository.deleteCurrentUser();
      logger.d('SignInInitial после выхода');
    });

    on<SignInLoadingDataEvent>((event, emit) async {
      logger.d('Нупиздяо');
      emit(SignInLoading());
      try {
        logger.d('Нупиздец');
        await MyLocator.userRepository.signIn(event.email, event.password);
        logger.d('Засигинился');
        if (MyLocator.userRepository.isAuthorized) {
          emit(IsAuthentication());
        } else {
          emit(SignInInitial());
        }
      } catch (e) {
        if (e.toString().contains('firebase_auth/invalid-credential')) {
          emit(SignInError(
              error:
                  "Пожалуйста, проверьте свои учетные данные и повторите попытку"));
        } else {
          emit(SignInError(
              error:
                  "Произошла ошибка входа. Пожалуйста, попробуйте еще раз позже"));
        }
      }
    });

    on<SignUpLoadingDataEvent>((event, emit) async {
      emit(SignUpLoading());

      MyLocator.userRepository.setImage(event.photo);
      await MyLocator.userRepository
          .signUp(event.email, event.password, event.name);
    });

    on<CancelSignUpEvent>((event, emit) {
      emit(SignUpInitial());
    });

    on<SignUpLoadedDataEvent>((event, emit) {
      emit(SignUpEmailVerify(email: event.email));
    });

    on<IsAuthenticationEvent>((event, emit) {
      emit(IsAuthentication());
    });
  }

  void addAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {}
}
