import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:secure_link_messenger/src/app/di.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SuccesChanges()) {
    on<GoRessetPasswordEvent>((event, emit) async {
      emit(StartRessetPassword());
    });

    on<LoadingPasswordEvent>((event, emit) async {
      emit(LoadingRessetPassword());
      await MyLocator.userRepository
          .changePassword(event.currentPassword, event.newPassword);
      emit(LoadedRessetPassword());
    });

    on<IsRessetPasswordEvent>((event, emit) {
      emit(SuccesChanges());
    });

    on<GoUpdateNameEvent>((event, emit) {
      emit(StartRessetName());
    });

    on<LoadingNameEvent>((event, emit) async {
      emit(LoadedRessetName());
      await MyLocator.userRepository.updateUserName(event.newName);
      emit(LoadedRessetName());
    });

    on<IsUpdatedNameEvent>((event, emit) {
      emit(SuccesChanges());
    });

    on<LoadingAvatarEvent>((event, emit) async {
      emit(LoadingNewAvatar());
      await MyLocator.userRepository.updateProfilePicture(event.newAvatar);
      emit(LoadedNewAvatar());
    });

    on<IsUpdatedAvatarEvent>((event, emit) {
      emit(SuccesChanges());
    });
  }
}
