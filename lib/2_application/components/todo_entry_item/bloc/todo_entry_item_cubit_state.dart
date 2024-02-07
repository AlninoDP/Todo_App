part of 'todo_entry_item_cubit.dart';

abstract class ToDoEntryItemState extends Equatable {
  const ToDoEntryItemState();

  @override
  List<Object> get props => [];
}

class ToDoEntryItemLoadingState extends ToDoEntryItemState {}

class ToDoEntryItemErrorState extends ToDoEntryItemState {}

class ToDoEntryItemLoadedState extends ToDoEntryItemState {
  final ToDoEntry toDoEntry;
  const ToDoEntryItemLoadedState({required this.toDoEntry});

  @override
  List<Object> get props => [];
}
