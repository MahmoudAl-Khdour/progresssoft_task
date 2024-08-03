import 'package:mockito/annotations.dart';
import 'package:progresssoft_task/core/utils/repository/app_repository.dart';
import 'package:progresssoft_task/features/app/data/services/config_service.dart';
import 'package:progresssoft_task/features/app/domian/repositories/config_repository.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_countries.dart';
import 'package:progresssoft_task/features/app/domian/usecases/get_all_validators.dart';

@GenerateMocks(
  [
    ConfigRepository,
    FirebaseConfigService,
    GetAllCountriesUseCase,
    GetAllValidatorsUseCase,
    AppRepository,
  ],
)
void main() {}
