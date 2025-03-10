import 'package:alw_alw/core/error/faliure.dart';
import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AddPepoleRepo {
  Future<Either<Faliure, AddPepoleEntity>> addUserData(
      {required AddPepoleEntity user});
}
