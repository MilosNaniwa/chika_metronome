import 'dart:async';

import 'package:chika_metronome/screen/metronome/metronome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundpool/soundpool.dart';

class MetronomeScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MetronomeScreenPageState();
}

class _MetronomeScreenPageState extends State<MetronomeScreenPage> {
  MetronomeScreenBloc _bloc;

  bool _isEnabledPlaybackMode;

  StreamSubscription _metronomeSubscription;

  Soundpool _soundPool;
  var _soundData;
  var _soundId;

  @override
  void initState() {
    super.initState();

    _soundPool = Soundpool(
      streamType: StreamType.notification,
      maxStreams: 10,
    );

    _isEnabledPlaybackMode = false;

    _bloc = MetronomeScreenBloc();

    _bloc.add(
      OnRequestInitializingEvent(),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _metronomeSubscription?.cancel();
    _soundPool.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (BuildContext context, state) async {
        // 初期化後
        if (state is InitializedState) {
          _soundData = await rootBundle.load(
            "assets/sounds/decision1.mp3",
          );
          _soundId = await _soundPool.load(_soundData);

          _bloc.add(
            OnCompleteRenderingEvent(),
          );
        }

        // 再生操作中
        else if (state is PlaybackOperatingState) {
          _isEnabledPlaybackMode = true;

          _metronomeSubscription = Stream.periodic(
            Duration(
              milliseconds: 300,
            ),
          ).listen(
            (x) async {
              await _soundPool.play(_soundId);
            },
          );

          _bloc.add(
            OnCompletePlayingEvent(),
          );
        }

        // 再生操作後
        else if (state is PlaybackOperatedState) {
          _bloc.add(
            OnCompleteRenderingEvent(),
          );
        }

        // 停止操作中
        else if (state is PauseOperatingState) {
          _isEnabledPlaybackMode = false;

          _metronomeSubscription.pause();

          _bloc.add(
            OnCompletePausingEvent(),
          );
        }

        // 停止操作後
        else if (state is PauseOperatingState) {
          _bloc.add(
            OnCompleteRenderingEvent(),
          );
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "タイトル",
            ),
          ),
          body: Center(
            child: _isEnabledPlaybackMode
                ? IconButton(
                    onPressed: () {
                      _bloc.add(
                        OnRequestPausingEvent(),
                      );
                    },
                    icon: Icon(
                      Icons.pause_circle_filled,
                    ),
                    iconSize: 60.0,
                  )
                : IconButton(
                    onPressed: () {
                      _bloc.add(
                        OnRequestPlayingEvent(),
                      );
                    },
                    icon: Icon(
                      Icons.play_circle_filled,
                    ),
                    iconSize: 60.0,
                  ),
          ),
        );
      },
    );
  }
}
