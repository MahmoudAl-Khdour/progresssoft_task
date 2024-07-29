import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseInitialState()) {
    on<ChangeCurrentIndexEvent>((event, emit) {
      emit(ChangeCurrentIndexState(index: event.index));
    });
  }
}
