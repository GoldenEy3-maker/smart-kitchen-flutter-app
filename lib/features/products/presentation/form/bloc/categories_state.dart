part of "categories_bloc.dart";

class CategoriesState extends Equatable {
  const CategoriesState({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}
