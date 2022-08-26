// ignore_for_file: file_names

part of 'GameBLoC.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}
