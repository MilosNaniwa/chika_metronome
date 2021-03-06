import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MetronomeScreenState extends Equatable {
  @override
  List<Object> get props => [];
}

class UninitializedState extends MetronomeScreenState {
  @override
  String toString() => '初期化前';
}

class InitializingState extends MetronomeScreenState {
  @override
  String toString() => '初期化中';
}

class InitializedState extends MetronomeScreenState {
  @override
  String toString() => '初期化後';
}

class IdlingState extends MetronomeScreenState {
  @override
  String toString() => '待機中';
}

class PlaybackOperatingState extends MetronomeScreenState {
  @override
  String toString() => '再生操作中';
}

class PlaybackOperatedState extends MetronomeScreenState {
  @override
  String toString() => '再生操作後';
}

class PauseOperatingState extends MetronomeScreenState {
  @override
  String toString() => '停止操作中';
}

class PauseOperatedState extends MetronomeScreenState {
  @override
  String toString() => '停止操作後';
}

class BpmChangingState extends MetronomeScreenState {
  final changeMode;

  BpmChangingState({
    @required this.changeMode,
  });

  @override
  String toString() => 'BPM変更中';
}

class BpmChangedState extends MetronomeScreenState {
  @override
  String toString() => 'BPM変更後';
}
