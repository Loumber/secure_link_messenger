part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

class StartRessetPassword extends SettingsState {}

class LoadingRessetPassword extends SettingsState {}

class LoadedRessetPassword extends SettingsState {}

class SuccesChanges extends SettingsState {}

class StartRessetName extends SettingsState {}

class LoadingRessetName extends SettingsState {}

class LoadedRessetName extends SettingsState {}

class LoadingNewAvatar extends SettingsState {}

class LoadedNewAvatar extends SettingsState {}
