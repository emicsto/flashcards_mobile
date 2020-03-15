import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterEvent extends Equatable {
  final int index;
  final int page;

  const CounterEvent(this.index, this.page);

  @override
  List<Object> get props => [index, page];
}

class DoAction extends CounterEvent {
  DoAction(int index, int page) : super(index, page);
}
