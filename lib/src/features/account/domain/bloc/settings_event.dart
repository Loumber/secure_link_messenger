part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class GoRessetPasswordEvent extends SettingsEvent {}

class LoadingPasswordEvent extends SettingsEvent {
  final String currentPassword;
  final String newPassword;

  LoadingPasswordEvent(
      {required this.currentPassword, required this.newPassword});
}

class IsRessetPasswordEvent extends SettingsEvent {}

class GoUpdateNameEvent extends SettingsEvent {}

class LoadingNameEvent extends SettingsEvent {
  final String newName;

  LoadingNameEvent({required this.newName});
}

class IsUpdatedNameEvent extends SettingsEvent {}

class LoadingAvatarEvent extends SettingsEvent {
  final File newAvatar;

  LoadingAvatarEvent({required this.newAvatar});
}

class IsUpdatedAvatarEvent extends SettingsEvent {}
