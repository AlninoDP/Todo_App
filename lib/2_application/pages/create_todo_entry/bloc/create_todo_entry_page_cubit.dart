import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/form_value.dart';

part 'create_todo_entry_page_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateToDoEntryPageState> {
  CreateToDoEntryPageCubit(
      {required this.collectionId, required this.createToDoEntry})
      : super(const CreateToDoEntryPageState());

  final CollectionId collectionId;
  final CreateToDoEntry createToDoEntry;

  void descriptionChanged({String? description}) {
    /// validate form
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.succes;
    }

    emit(
      state.copyWith(
        description:
            FormValue(value: description, validationStatus: currentStatus),
      ),
    );
  }

  void submit() {}
}
