import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_overview_cubit_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewCubitState> {
  TodoOverviewCubit(
      {required this.loadToDoCollections, TodoOverviewCubitState? initialState})
      : super(
          initialState ?? TodoOverviewCubitLoadingState(),
        );

  final LoadToDoCollections loadToDoCollections;

  Future<void> readToDoCollections() async {
    emit(TodoOverviewCubitLoadingState());
    try {
      final collectionsFuture = loadToDoCollections.call(NoParams());
      final collections = await collectionsFuture;

      collections.fold(
        (failure) => emit(TodoOverviewCubitErrorState()),
        (success) => emit(
          TodoOverviewCubitLoadedState(collections: success),
        ),
      );
    } on Exception {
      emit(TodoOverviewCubitErrorState());
    }
  }
}
