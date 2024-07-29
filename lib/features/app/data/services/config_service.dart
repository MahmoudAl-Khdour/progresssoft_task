import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/error/exceptions.dart';
import 'package:progresssoft_task/core/error/failures.dart';
import 'package:progresssoft_task/core/strings/messages.dart';
import 'package:progresssoft_task/features/app/data/models/countries_model.dart';
import 'package:progresssoft_task/features/app/data/models/validators_model.dart';

class FirebaseConfigService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<Either<Failure, CountriesModel>> getAllCountries() async {
    try {
      final config = await _fireStore.collection('config').doc('country').get();

      if (config.exists) {
        final configData = config.data();
        if (configData != null) {
          return Right(CountriesModel.fromJson(configData));
        } else {
          return Left(ServerFailure(message: AppMessages.noDataCountries.tr));
        }
      } else {
        return Left(ServerFailure(message: AppMessages.noDataCountries.tr));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  Future<Either<Failure, ValidatorsModel>> getAllValidators() async {
    try {
      final config =
          await _fireStore.collection('config').doc('validators').get();

      if (config.exists) {
        final validatorsData = config.data();
        if (validatorsData != null) {
          return Right(ValidatorsModel.fromJson(validatorsData));
        } else {
          return Left(ServerFailure(message: AppMessages.noDataValidators.tr));
        }
      } else {
        return Left(ServerFailure(message: AppMessages.noDataValidators.tr));
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.msg));
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
