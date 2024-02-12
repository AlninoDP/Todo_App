import 'package:dartz/dartz.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class UpdateToDoEntry implements UseCase<ToDoEntry, ToDoEntryIdParam> {
  const UpdateToDoEntry({required this.toDoRepository});
  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdParam params) async {
    try {
      final loadedEntry = await toDoRepository.updateToDoEntry(
        collectionId: params.collectionId,
        entryId: params.entryId,
      );
      return loadedEntry.fold(
        (failure) => Left(failure),
        (toDoEntry) => Right(toDoEntry),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
