import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CounterInitial();

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if(event is DoAction) {
      yield CounterInitial(index: event.index, page: event.page);
    }
  }
}
