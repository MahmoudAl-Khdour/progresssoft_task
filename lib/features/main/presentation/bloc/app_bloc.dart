import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/features/app/repository/app_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppRepository appRepository;
  final String countryCode = '+962';
  AppBloc({
    required this.appRepository,
  }) : super(AppInitialState()) {
    on<ChangeCurrentIndexEvent>((event, emit) {
      emit(ChangeCurrentIndexState(index: event.index));
    });
  }
}
