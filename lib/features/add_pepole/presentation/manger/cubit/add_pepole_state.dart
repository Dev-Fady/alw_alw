part of 'add_pepole_cubit.dart';

@immutable
sealed class AddPepoleState {}

final class AddPepoleInitial extends AddPepoleState {}

final class AddPepoleLoading extends AddPepoleState {}

final class AddPepoleSuccess extends AddPepoleState {}

final class AddPepoleFailure extends AddPepoleState {}
