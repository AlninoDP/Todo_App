import 'package:dartz/dartz.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class LoadToDoEntry implements UseCase<ToDoEntry, ToDoEntryIdParam> {
  const LoadToDoEntry({required this.toDoRepository});
  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdParam params) async {
    try {
      final loadedEntry = await toDoRepository.readToDoEntry(
          params.collectionId, params.entryId);

      return loadedEntry.fold(
        (failure) => Left(failure),
        (toDoEntry) => Right(toDoEntry),
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(stackTrace: e.toString()),
      );
    }
  }
}
