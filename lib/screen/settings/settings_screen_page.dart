import 'package:chika_metronome/screen/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsScreenPageState();
}

class _SettingsScreenPageState extends State<SettingsScreenPage> {
  SettingsScreenBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = SettingsScreenBloc();

    _bloc.add(
      OnRequestInitializingEvent(),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (BuildContext context, state) {
        // 初期化後
        if (state is InitializedState) {
          _bloc.add(
            OnCompleteRenderingEvent(),
          );
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            title: Text(
              "タイトル",
            ),
          ),
          body: Center(
            child: Text(
              "ボディ",
            ),
          ),
        );
      },
    );
  }
}
