import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/0_data/data_sources/local/memory_local_data_source.dart';
import 'package:todo_app/0_data/repositories/todo_local_repository.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/2_application/app/basic_app.dart';

/// RepositoryProvider is part of the flutter_bloc library
/// and is used to provide a repository to the widget tree.
void main() {
  runApp(RepositoryProvider<ToDoRepository>(
    create: (context) => ToDoLocalRepository(
      localDataSource: MemoryLocalDataSource(),
    ),
    child: const BasicApp(),
  ));
}
