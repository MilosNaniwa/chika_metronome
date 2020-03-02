import 'package:equatable/equatable.dart';

class SettingsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnRequestInitializingEvent extends SettingsScreenEvent {
  @override
  String toString() => '初期化要求';
}

class OnCompleteRenderingEvent extends SettingsScreenEvent {
  @override
  String toString() => '描画完了';
}
