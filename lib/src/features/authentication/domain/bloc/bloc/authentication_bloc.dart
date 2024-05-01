import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/user/user_entity.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/sign_up.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  late AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(): super(AuthenticationInitial()){

    on<GoSignInEvent>((event,emit){
      emit(SignInInitial());
    });

    on<GoSignUpEvent>((event, emit){
      emit(SignUpInitial());
    });

 //   on<GoAuthenticationEvent>(_checkAuthentication());

    on<SignUpLoadingDataEvent>((event,emit){
      emit(SignUpLoading());
      
    });

    on<SignUpLoadedDataEvent>((event,emit){
      emit(SignUpEmailVerify());
    });

    on<IsSignUpEvent>((event,emit){
      emit(IsAuthentication());
    });

  }


  void addAuthenticationRepository(AuthenticationRepository authenticationRepository){
    _authenticationRepository = authenticationRepository;
  }

  Future<void> _checkAuthentication(event,emit,)async {
    emit(AuthenticationInitial());
    
    
  }
}
