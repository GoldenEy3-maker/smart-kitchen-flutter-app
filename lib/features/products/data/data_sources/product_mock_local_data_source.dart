import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";

import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/products/data/models/models.dart";

import "product_local_data_source.dart";

class ProductMockLocalDataSource implements ProductLocalDataSource {
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return Right([
      CategoryModel(
        id: "vegetables",
        label: "Овощи",
        iconKey: CatalogIcon.broccoli.name,
      ),
      CategoryModel(
        id: "fruits",
        label: "Фрукты",
        iconKey: CatalogIcon.apple.name,
      ),
      CategoryModel(id: "meat", label: "Мясо", iconKey: CatalogIcon.beef.name),
      CategoryModel(id: "fish", label: "Рыба", iconKey: CatalogIcon.fish.name),
      CategoryModel(
        id: "dairy",
        label: "Молоко",
        iconKey: CatalogIcon.milk.name,
      ),
      CategoryModel(
        id: "bread",
        label: "Хлеб",
        iconKey: CatalogIcon.wheat.name,
      ),
      CategoryModel(
        id: "alcohol",
        label: "Алкоголь",
        iconKey: CatalogIcon.wine.name,
      ),
      CategoryModel(
        id: "other",
        label: "Другие",
        iconKey: CatalogIcon.package.name,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    return Right([
      ProductModel(
        id: "1",
        name: "Картофель",
        iconKey: CatalogIcon.broccoli.name,
        unit: "кг",
        categoryId: "vegetables",
      ),
      ProductModel(
        id: "2",
        name: "Яблоко",
        iconKey: CatalogIcon.apple.name,
        unit: "шт",
        categoryId: "fruits",
      ),
      ProductModel(
        id: "3",
        name: "Говядина",
        iconKey: CatalogIcon.beef.name,
        unit: "кг",
        categoryId: "meat",
      ),
      ProductModel(
        id: "4",
        name: "Лосось",
        iconKey: CatalogIcon.fish.name,
        unit: "шт",
        categoryId: "fish",
      ),
      ProductModel(
        id: "5",
        name: "Молоко",
        iconKey: CatalogIcon.milk.name,
        unit: "л",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "6",
        name: "Хлеб",
        iconKey: CatalogIcon.wheat.name,
        unit: "шт",
        categoryId: "bread",
      ),
      ProductModel(
        id: "7",
        name: "Пиво",
        iconKey: CatalogIcon.beer.name,
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "8",
        name: "Салат",
        iconKey: CatalogIcon.salad.name,
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "9",
        name: "Творог",
        iconKey: CatalogIcon.milk.name,
        unit: "г",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "10",
        name: "Спагетти",
        iconKey: CatalogIcon.salad.name,
        unit: "г",
        categoryId: "bread",
      ),
      ProductModel(
        id: "11",
        name: "Вино",
        iconKey: CatalogIcon.wine.name,
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "12",
        name: "Гамбургер",
        iconKey: CatalogIcon.hamburger.name,
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "13",
        name: "Сыр",
        iconKey: CatalogIcon.egg.name,
        unit: "г",
        categoryId: "dairy",
      ),
    ]);
  }
}
