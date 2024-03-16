import 'package:dartz/dartz.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class ToDoRepositoryMock implements ToDoRepository {
// List of todo entry
  final List<ToDoEntry> toDoEntries = List.generate(
    100,
    (index) => ToDoEntry(
        description: 'description $index',
        id: EntryId.fromUniqueString(index.toString()),
        isDone: false),
  );

// List Of TodoCollection
  final toDoCollections = List<ToDoCollection>.generate(
    10,
    (index) => ToDoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      color: ToDoColor(colorIndex: index % ToDoColor.predefinedColors.length),
    ),
  );

// Method
  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    try {
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  /// used in LoadToDoEntry UseCase and ToDoEntryItem page (cubit loaded state)
  /// used to provide the task(ToDoEntry) for each of collection id
  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final selectedEntryItem =
          toDoEntries.firstWhere((element) => element.id == entryId);

      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(selectedEntryItem),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  /// used in LoadToDoEntryIdsForCollection UseCase and detail page (cubit loaded state)
  /// used to load detail of the task(ToDoEntry) of each collection id
  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) {
    try {
      final startIndex = int.parse(collectionId.value) * 10;
      int endIndex = startIndex + 10;
      if (toDoEntries.length < endIndex) {
        endIndex = toDoEntries.length;
      }
      List<EntryId> entryIds = [];
      if (startIndex < toDoEntries.length) {
        entryIds = toDoEntries
            .sublist(startIndex, endIndex)
            .map((entry) => entry.id)
            .toList();
      }

      return Future.delayed(
          const Duration(milliseconds: 300), () => Right(entryIds));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  /// used to update task in detail page, changing the value of isDone in ToDoEntry
  /// used in UpdateToDoEntry UseCase
  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      {required CollectionId collectionId, required EntryId entryId}) {
    final index = toDoEntries.indexWhere((element) => element.id == entryId);
    final entryToUpdate = toDoEntries[index];
    final updatedEntry =
        toDoEntries[index].copyWith(isDone: !entryToUpdate.isDone);
    toDoEntries[index] = updatedEntry;
    return Future.delayed(
        const Duration(milliseconds: 100), () => Right(updatedEntry));
  }

  /// used in CreateToDoCollection UseCase and Overview page(cubit loaded state)
  /// used for creating ToDoCollection
  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) {
    final collectionToAdd = ToDoCollection(
        id: CollectionId.fromUniqueString(toDoCollections.length.toString()),
        title: collection.title,
        color: collection.color);
    toDoCollections.add(collectionToAdd);
    return Future.delayed(
        const Duration(milliseconds: 100), () => const Right(true));
  }

  /// used in CreateToDoEntry UseCase and
  @override
  Future<Either<Failure, bool>> createToDoEntry(_, ToDoEntry entry) {
    toDoEntries.add(entry);
    return Future.delayed(
        const Duration(microseconds: 300), () => const Right(true));
  }
}
