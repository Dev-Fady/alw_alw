import 'package:alw_alw/features/add_pepole/domain/entites/add_pepole_entity.dart';
import 'package:alw_alw/features/add_pepole/domain/repo/add_pepole_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_pepole_state.dart';

class AddPepoleCubit extends Cubit<AddPepoleState> {
  AddPepoleCubit(this.addPepoleRepo) : super(AddPepoleInitial());
  final AddPepoleRepo addPepoleRepo;
  Future<void> addPepole(AddPepoleEntity addPepoleEntity) async {
    emit(AddPepoleLoading());
    final result = await addPepoleRepo.addUserData(user: addPepoleEntity);
    result.fold(
      (l) => emit(AddPepoleFailure()),
      (r) => emit(AddPepoleSuccess()),
    );
  }
}
