part of 'navigation_todo_cubit.dart';

class NavigationToDoCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyIsDisplayed;

  const NavigationToDoCubitState(
      {this.selectedCollectionId, this.isSecondBodyIsDisplayed});

  @override
  List<Object?> get props => [selectedCollectionId, isSecondBodyIsDisplayed];
}
