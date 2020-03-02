import 'package:equatable/equatable.dart';

class MetronomeScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnRequestInitializingEvent extends MetronomeScreenEvent {
  @override
  String toString() => '初期化要求';
}

class OnCompleteRenderingEvent extends MetronomeScreenEvent {
  @override
  String toString() => '描画完了';
}

class OnRequestPlayingEvent extends MetronomeScreenEvent {
  @override
  String toString() => '再生要求';
}

class OnCompletePlayingEvent extends MetronomeScreenEvent {
  @override
  String toString() => '再生完了';
}

class OnRequestPausingEvent extends MetronomeScreenEvent {
  @override
  String toString() => '停止要求';
}

class OnCompletePausingEvent extends MetronomeScreenEvent {
  @override
  String toString() => '停止完了';
}