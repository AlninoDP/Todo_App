import 'package:equatable/equatable.dart';

class FormValue<T> with EquatableMixin {
  final T value;
  final ValidationStatus validationStatus;

  FormValue({required this.value, required this.validationStatus});

  @override
  List<Object?> get props => [];
}

enum ValidationStatus {
  error,
  succes,
  pending,
}
