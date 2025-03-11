// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:alw_alw/features/home/domain/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.homeRepo,
  ) : super(HomeInitial());
  final HomeRepo homeRepo;
  Future<void> getUser() async {
    emit(HomeLoading());
    final result = await homeRepo.getUser();
    result.fold(
      (l) => emit(HomeFailure()),
      (r) => emit(HomeSuccess(users: r)),
    );
  }
}
