import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';

/// abstract class representing usecases
/// method call takes parameters of type Params and returns a Future of Either<Failure, Type>
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// abstract class representing parameter that can be passed to usecase
abstract class Params extends Equatable {}

/// abstract class represent a case where parameter are not required
/// used in LoadToDoCollection
class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

/// parameter to provide EntryId and CollectionId
/// used in LoadToDoEntry usecase
class ToDoEntryIdParam extends Params {
  ToDoEntryIdParam({required this.collectionId, required this.entryId})
      : super();

  final EntryId entryId;
  final CollectionId collectionId;

  @override
  List<Object?> get props => [collectionId, entryId];
}

/// parameter to provide only CollectionId
/// used in LoadToDoEntryIdsForCollection usecase
class CollectionIdParam extends Params {
  CollectionIdParam({required this.collectionId}) : super();

  final CollectionId collectionId;

  @override
  List<Object?> get props => [collectionId];
}

/// parameter to provide only ToDoCollection
/// used in CreateToDoCollection usecase
class ToDoCollectionParams extends Params {
  ToDoCollectionParams({required this.collection}) : super();

  final ToDoCollection collection;

  @override
  List<Object?> get props => [collection];
}

/// parameter to provide ToDoEntry
/// used in CreateToDoEntry usecase
class ToDoEntryParams extends Params {
  ToDoEntryParams({required this.entry}) : super();

  final ToDoEntry entry;

  @override
  List<Object?> get props => [entry];
}
