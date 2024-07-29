import 'package:equatable/equatable.dart';

class CountriesModel extends Equatable {
  final List<String> countries;

  const CountriesModel({
    required this.countries,
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

  @override
  List<Object?> get props => [countries];
}
