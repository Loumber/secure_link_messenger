import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/entities/user/user_entity.dart';
import 'package:secure_link_messenger/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:secure_link_messenger/src/features/authentication/presentation/widgets/sign_up.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(): super(SignUpInitial()){

    on<LoadingDataEvent>((event,emit){
      emit(SignUpLoading());
    });

    on<LoadedDataEvent>((event,emit){
      emit(SignUpEmailVerify());
    });

    on<IsSignUpEvent>((event,emit){
      emit(IsSignUp());
    });

  }
}
