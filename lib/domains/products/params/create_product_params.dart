class CreateProductParams {
  const CreateProductParams({
    required this.name,
    required this.iconKey,
    required this.unit,
    required this.categoryId,
  });

  final String name;
  final String iconKey;
  final String unit;
  final String categoryId;
}
