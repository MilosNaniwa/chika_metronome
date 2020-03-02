import 'package:bloc/bloc.dart';
import 'package:chika_metronome/screen/settings/settings_screen.dart';

class SettingsScreenBloc
    extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  @override
  String toString() => 'サンプル画面';

  @override
  SettingsScreenState get initialState => UninitializedState();

  @override
  Stream<SettingsScreenState> mapEventToState(
      SettingsScreenEvent event) async* {
    // 初期化要求
    if (event is OnRequestInitializingEvent) {
      yield InitializingState();

      yield InitializedState();
    }

    // 描画完了
    else if (event is OnCompleteRenderingEvent) {
      yield IdlingState();
    }
  }
}
