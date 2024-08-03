import 'package:progresssoft_task/features/app/domian/entites/countries_entity.dart';

class CountriesModel extends CountriesEntity {
  const CountriesModel({
    required super.countries,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      countries: List<String>.from(json['countries']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries': countries,
    };
  }
}
