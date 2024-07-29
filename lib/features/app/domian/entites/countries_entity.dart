import 'package:equatable/equatable.dart';

class CountriesEntity extends Equatable {
  final List<String> countries;

  const CountriesEntity({
    required this.countries,
  });

  @override
  List<Object?> get props => [countries];
}
