import 'package:equatable/equatable.dart';

class SettingsScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class UninitializedState extends SettingsScreenState {
  @override
  String toString() => '初期化前';
}

class InitializingState extends SettingsScreenState {
  @override
  String toString() => '初期化中';
}

class InitializedState extends SettingsScreenState {
  @override
  String toString() => '初期化後';
}

class IdlingState extends SettingsScreenState {
  @override
  String toString() => '待機中';
}
