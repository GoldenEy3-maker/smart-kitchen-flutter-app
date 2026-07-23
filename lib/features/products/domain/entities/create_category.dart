import "package:equatable/equatable.dart";

class CreateCategory extends Equatable {
  final String label;
  final String iconKey;

  const CreateCategory({required this.label, required this.iconKey});

  @override
  List<Object?> get props => [label, iconKey];
}
