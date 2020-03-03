import 'package:bloc/bloc.dart';
import 'package:chika_metronome/screen/metronome/metronome_screen.dart';

class MetronomeScreenBloc
    extends Bloc<MetronomeScreenEvent, MetronomeScreenState> {
  @override
  String toString() => 'サンプル画面';

  @override
  MetronomeScreenState get initialState => UninitializedState();

  @override
  Stream<MetronomeScreenState> mapEventToState(
      MetronomeScreenEvent event) async* {
    // 初期化要求
    if (event is OnRequestInitializingEvent) {
      yield InitializingState();

      yield InitializedState();
    }

    // 描画完了
    else if (event is OnCompleteRenderingEvent) {
      yield IdlingState();
    }

    // 再生要求
    else if (event is OnRequestPlayingEvent) {
      yield PlaybackOperatingState();
    }

    // 再生完了
    else if (event is OnCompletePlayingEvent) {
      yield PlaybackOperatingState();
    }

    // 停止要求
    else if (event is OnRequestPausingEvent) {
      yield PauseOperatingState();
    }

    // 停止要求
    else if (event is OnCompletePausingEvent) {
      yield PauseOperatedState();
    }

    // BPM変更要求
    else if (event is OnRequestChangingBpmEvent) {
      yield BpmChangingState(
        changeMode: event.changeMode,
      );
    }

    // BPM変更完了
    else if (event is OnCompleteChangingBpmEvent) {
      yield BpmChangedState();
    }
  }
}
