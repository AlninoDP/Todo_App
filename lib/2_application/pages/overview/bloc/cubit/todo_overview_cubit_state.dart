part of 'todo_overview_cubit.dart';

sealed class TodoOverviewCubitState extends Equatable {
  const TodoOverviewCubitState();

  @override
  List<Object> get props => [];
}

final class TodoOverviewCubitInitial extends TodoOverviewCubitState {}

class TodoOverviewCubitLoadingState extends TodoOverviewCubitState {}

class TodoOverviewCubitErrorState extends TodoOverviewCubitState {}

class TodoOverviewCubitLoadedState extends TodoOverviewCubitState {
  final List<ToDoCollection> collections;
  const TodoOverviewCubitLoadedState({required this.collections});

  @override
  List<Object> get props => [];
}
