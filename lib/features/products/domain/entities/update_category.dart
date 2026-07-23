import "package:equatable/equatable.dart";

class UpdateCategory extends Equatable {
  final String id;
  final String? label;
  final String? iconKey;

  const UpdateCategory({required this.id, this.label, this.iconKey});

  @override
  List<Object?> get props => [id, label, iconKey];
}
