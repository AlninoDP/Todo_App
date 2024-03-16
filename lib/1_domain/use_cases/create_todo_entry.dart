import 'package:dartz/dartz.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class CreateToDoEntry implements UseCase<bool, ToDoEntryParams> {
  final ToDoRepository toDoRepository;
  CreateToDoEntry({required this.toDoRepository});

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = await toDoRepository.createToDoEntry(
          params.collectionId, params.entry);
      return result.fold(
        (failure) => Left(failure),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
