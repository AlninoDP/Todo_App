part of 'todo_detail_cubit.dart';

sealed class ToDoDetailCubitState extends Equatable {
  const ToDoDetailCubitState();

  @override
  List<Object> get props => [];
}

final class ToDoDetailCubitLoadingState extends ToDoDetailCubitState {}

final class ToDoDetailCubitErrorState extends ToDoDetailCubitState {}

final class ToDoDetailCubitLoadedState extends ToDoDetailCubitState {
  final List<EntryId> entryIds;
  const ToDoDetailCubitLoadedState({required this.entryIds});

  @override
  List<Object> get props => [entryIds];
}
