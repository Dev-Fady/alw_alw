import 'dart:developer';

import 'package:alw_alw/core/error/faliure.dart';
import 'package:alw_alw/core/services/firebase/firestore_service.dart';
import 'package:alw_alw/features/add_pepole/data/model/add_pepole_model.dart';
import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';
import 'package:alw_alw/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl implements HomeRepo {
  final FirestoreService firestoreService;
  HomeRepoImpl({required this.firestoreService});
  @override
  Future<Either<Faliure, List<AddPepoleEntity>>> getUser() async {
    try {
      final result =
          await firestoreService.getAllDocuments(collectionPath: "users");
      final userList =
          result.map((doc) => AddPepoleModel.fromJson(doc)).toList();
      final userEntityList = userList.map((model) => model.toEntity()).toList();
      return Right(userEntityList);
    } catch (e) {
      log('HomeRepoImpl.getUser: $e');
      return Left(ServerFaliure('حدث خطأ ما. الرجاء المحاولة مرة أخرى.'));
    }
  }
}
