import 'package:dartz/dartz.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class LoadToDoCollections implements UseCase<List<ToDoCollection>, NoParams> {
  final ToDoRepository toDoRepository;
  const LoadToDoCollections({required this.toDoRepository});

  @override
  Future<Either<Failure, List<ToDoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = await toDoRepository.readToDoCollections();
      return loadedCollections.fold(
        (failure) => Left(failure),
        (listToDoCollection) => Right(listToDoCollection),
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          stackTrace: e.toString(),
        ),
      );
    }
  }
}
