import 'dart:async';

import 'package:chika_metronome/common/constants.dart';
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
  ByteData _soundData;
  int _soundId;

  int _bpm;

  @override
  void initState() {
    super.initState();

    _bpm = 60;

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
            Constants.pathToSound,
          );
          _soundId = await _soundPool.load(_soundData);

          _bloc.add(
            OnCompleteRenderingEvent(),
          );
        }

        // 再生操作中
        else if (state is PlaybackOperatingState) {
          _isEnabledPlaybackMode = true;

          final microSeconds = 60 / _bpm * 1000000;

          await _metronomeSubscription?.cancel();
          _metronomeSubscription = Stream.periodic(
            Duration(
              microseconds: microSeconds.floor(),
            ),
          ).listen(
            (x) {
              _soundPool.play(_soundId);
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

          _metronomeSubscription?.cancel();

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

        // BPM変更中
        else if (state is BpmChangingState) {
          if (state.changeMode == MetronomeScreenConst.plus) {
            _bpm++;
          } else if (state.changeMode == MetronomeScreenConst.minus) {
            _bpm--;
          }

          _bloc.add(
            OnCompleteChangingBpmEvent(),
          );
        }

        // BPM変更後
        else if (state is BpmChangedState) {
          _bloc.add(
            OnRequestPlayingEvent(),
          );
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "メトロ",
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _bpm.toString(),
                      style: TextStyle(
                        fontSize: 100.0,
                      ),
                    ),
                  ),
                ),
                onTap: () => print(""),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                          ),
                          onPressed: () => _bloc.add(
                            OnRequestChangingBpmEvent(
                              changeMode: MetronomeScreenConst.minus,
                            ),
                          ),
                          iconSize: 60.0,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                          ),
                          onPressed: () => _bloc.add(
                            OnRequestChangingBpmEvent(
                              changeMode: MetronomeScreenConst.plus,
                            ),
                          ),
                          iconSize: 60.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              _isEnabledPlaybackMode
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
                      color: Colors.red,
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
                      color: Colors.green,
                    ),
            ],
          ),
        );
      },
    );
  }
}
