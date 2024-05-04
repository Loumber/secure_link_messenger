import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:secure_link_messenger/src/features/authentication/data/provider/domain_provider.dart';
import 'package:secure_link_messenger/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_in/user_sign_in_entity.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/sign_up/user_sign_up_entity.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/user/user_entity.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  
  DomainProvider _domainProvider = DomainProvider();
  AuthenticationRepositoryImpl _authenticationRepository = AuthenticationRepositoryImpl();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<GoSignInEvent>((event, emit) {
      emit(SignInInitial());
    });

    on<GoSignUpEvent>((event, emit) {
      emit(SignUpInitial());
    });

    //   on<GoAuthenticationEvent>(_checkAuthentication());

    on<SignInLoadingDataEvent>((event, emit) async {
      emit(SignInLoading());
      _domainProvider.registerSignInUser(
          UserSignInEntity(email: event.email, password: event.password));
      await _authenticationRepository.signIn();
      emit(IsAuthentication());
    });

    on<SignUpLoadingDataEvent>((event, emit) async {
      emit(SignUpLoading());
      _domainProvider.registerSignUpUser(UserSignUpEntity(
          email: event.email,
          name: event.name,
          password: event.password,
          photo: event.photo));
      await _authenticationRepository.signUp();
    });

    on<CancelSignUpEvent>((event, emit) {
      emit(SignUpInitial());
    });

    on<SignUpLoadedDataEvent>((event, emit) {
      emit(SignUpEmailVerify());
      bool isVerificated = _authenticationRepository.isEmailVerification();
      while(!isVerificated){ 
        Future.delayed(const Duration(seconds: 1),(){isVerificated =  _authenticationRepository.isEmailVerification();});
      }
      emit(IsAuthentication());
    });

    on<IsAuthenticationEvent>((event, emit) {
      emit(IsAuthentication());
    });
  }

  void addAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    
  }

  Future<void> _checkAuthentication(
    event,
    emit,
  ) async {
    emit(AuthenticationInitial());
  }
}
