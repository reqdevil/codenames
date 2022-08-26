// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'GameEvent.dart';
part 'GameState.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
