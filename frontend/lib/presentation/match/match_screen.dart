import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:undervoltage/domain/model/room.dart';
import 'package:undervoltage/domain/state/match/match_state.dart';
import 'package:undervoltage/utils/palette.dart';
import 'package:undervoltage/widgets/base_screen.dart';
import 'package:undervoltage/widgets/label.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance(Room room) => MatchScreen._(MatchState(room));

  @override
  Widget build(BuildContext context) {
    return StateProvider<MatchState>(
      state: state,
      builder: (context, state) => Body(state),
    );
  }
}

class Body extends StatelessWidget {
  final MatchState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: StateProvider<MatchState>(
          state: state,
          builder: (context, state) => Label(
            text: state.events.join('\n\n'),
            color: Palette.black,
            align: TextAlign.center,
            size: 14,
          ),
        ),
      ),
    );
  }
}