import 'dart:developer';

import 'package:alw_alw/core/error/faliure.dart';
import 'package:alw_alw/core/services/firebase/firestore_service.dart';
import 'package:alw_alw/features/add_pepole/data/model/add_pepole_model.dart';
import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';
import 'package:alw_alw/features/add_pepole/domain/repo/add_pepole_repo.dart';
import 'package:dartz/dartz.dart';

class AddPepoleRepoImpl implements AddPepoleRepo {
  final FirestoreService firestoreService;
  AddPepoleRepoImpl({required this.firestoreService});
  @override
  Future<Either<Faliure, AddPepoleEntity>> addUserData(
      {required AddPepoleEntity user}) async {
    try {
      await firestoreService.addDocument(
        collectionPath: "users",
        data: AddPepoleModel.fromEntity(user).toJson(),
        documentId: user.iD,
      );
      return Right(user);
    } catch (e) {
      log('Exception in AuthRepoImpl.addData $e');
      return Left(ServerFaliure('حدث خطأ ما. الرجاء المحاولة مرة أخرى.'));
    }
  }
}
