import "package:equatable/equatable.dart";

class Product extends Equatable {
  final String id;
  final String name;
  final String emoji;
  final String unit;
  final String categoryId;

  const Product({
    required this.id,
    required this.name,
    required this.emoji,
    required this.unit,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, name, emoji, unit, categoryId];
}
