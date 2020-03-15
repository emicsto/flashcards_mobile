import 'package:equatable/equatable.dart';
import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/widgets/flashcards/flashcard.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterState extends Equatable {
  const CounterState();
}

class CounterInitial extends CounterState {
  final index;
  final page;

  const CounterInitial({this.index = 0, this.page = 0});

  @override
  List<Object> get props => [index, page];
}

