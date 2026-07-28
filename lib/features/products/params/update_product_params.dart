class UpdateProductParams {
  const UpdateProductParams({
    required this.id,
    this.name,
    this.iconKey,
    this.unit,
    this.categoryId,
  });

  final String id;
  final String? name;
  final String? iconKey;
  final String? unit;
  final String? categoryId;
}
