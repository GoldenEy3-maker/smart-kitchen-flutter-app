import "package:equatable/equatable.dart";

class Category extends Equatable {
  final String id;
  final String label;
  final String emoji;

  const Category({required this.id, required this.label, required this.emoji});

  @override
  List<Object?> get props => [id, label, emoji];
}
