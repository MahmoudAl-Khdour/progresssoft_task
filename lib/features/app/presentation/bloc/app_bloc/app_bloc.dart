import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';
import 'package:progresssoft_task/features/app/domian/entites/validators.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_countries.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_validators.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetAllCountriesUseCase getAllCountriesUseCase;
  final GetAllValidatorsUseCase getAllValidatorsUseCase;
  final AppRepository appRepository;

  AppBloc({
    required this.getAllCountriesUseCase,
    required this.getAllValidatorsUseCase,
    required this.appRepository,
  }) : super(AppInitialState()) {
    on<GetCountriesEvent>((event, emit) async {
      await _onGetCountriesEvent(event, emit);
    });

    on<GetValidatorsEvent>((event, emit) async {
      await _onGetValidatorsEvent(event, emit);
    });
  }

  Future<void> _onGetCountriesEvent(
      GetCountriesEvent event, Emitter<AppState> emit) async {
    emit(AppLoadingState());
    final failureOrCountries = await getAllCountriesUseCase.call();
    emit(failureOrCountries.fold(
      (failure) => AppErrorState(message: _mapFailureToMessage(failure)),
      (countries) {
        appRepository.countries = countries;
        return AppCountriesLoadedState(countries: countries);
      },
    ));
  }

  Future<void> _onGetValidatorsEvent(
      GetValidatorsEvent event, Emitter<AppState> emit) async {
    emit(AppLoadingState());
    final failureOrValidators = await getAllValidatorsUseCase.call();
    emit(failureOrValidators.fold(
      (failure) => AppErrorState(message: _mapFailureToMessage(failure)),
      (validators) {
        appRepository.validators = validators;
        return AppValidatorsLoadedState(validators: validators);
      },
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? AppMessages.somethingWentWrongMessage;
  }
}
