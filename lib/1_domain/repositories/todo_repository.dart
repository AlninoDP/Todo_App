import 'package:dartz/dartz.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';

abstract class ToDoRepository {
  /// is responsible for fetching List of [ToDoCollection] in the storage
  /// and loading all [ToDoCollection] in [OverviewPage].
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();

  /// is responsible for loading the detailed information of
  /// each entry item displayed on the detail page
  /// used for LoadToDoEntry usecase, used in ToDoEntryItem
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId);

  /// is responsible for fetching the IDs of the entry items
  /// associated with a specific collection,
  /// facilitating the loading of entry items on the detail page
  /// used for LoadToDoEntryIdsForCollection usecase
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId);

  /// is responsible for updating task ([ToDoEntry.isDone]) or entry item.
  /// used for UpdateToDoEntry usecase.
  Future<Either<Failure, ToDoEntry>> updateToDoEntry({
    required CollectionId collectionId,
    required EntryId entryId,
  });

  /// is responsible for creating [ToDoCollection] and adding it to the storage
  /// used in CreateToDoCollection usecase and OverviewPage(cubit loaded state)
  Future<Either<Failure, bool>> createToDoCollection(ToDoCollection collection);

  /// is responsible for creating [ToDoEntry] and adding it to the storage
  /// depending on the [ToDoCollection.id], used in CreateToDoEntry usecase
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry entry);
}
