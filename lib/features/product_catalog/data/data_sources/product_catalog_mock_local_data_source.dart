import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/icons/catalog_icons.dart";

import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/data/models/models.dart";

import "product_catalog_local_data_source.dart";

class ProductCatalogMockLocalDataSource
    implements ProductCatalogLocalDataSource {
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return Right([
      CategoryModel(
        id: "vegetables",
        label: "Овощи",
        iconKey: CatalogIconsKeys.broccoli.name,
      ),
      CategoryModel(
        id: "fruits",
        label: "Фрукты",
        iconKey: CatalogIconsKeys.apple.name,
      ),
      CategoryModel(
        id: "meat",
        label: "Мясо",
        iconKey: CatalogIconsKeys.beef.name,
      ),
      CategoryModel(
        id: "fish",
        label: "Рыба",
        iconKey: CatalogIconsKeys.fish.name,
      ),
      CategoryModel(
        id: "dairy",
        label: "Молоко",
        iconKey: CatalogIconsKeys.milk.name,
      ),
      CategoryModel(
        id: "bread",
        label: "Хлеб",
        iconKey: CatalogIconsKeys.wheat.name,
      ),
      CategoryModel(
        id: "alcohol",
        label: "Алкоголь",
        iconKey: CatalogIconsKeys.wine.name,
      ),
      CategoryModel(
        id: "other",
        label: "Другие",
        iconKey: CatalogIconsKeys.package.name,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    return Right([
      ProductModel(
        id: "1",
        name: "Картофель",
        iconKey: CatalogIconsKeys.broccoli.name,
        unit: "кг",
        categoryId: "vegetables",
      ),
      ProductModel(
        id: "2",
        name: "Яблоко",
        iconKey: CatalogIconsKeys.apple.name,
        unit: "шт",
        categoryId: "fruits",
      ),
      ProductModel(
        id: "3",
        name: "Говядина",
        iconKey: CatalogIconsKeys.beef.name,
        unit: "кг",
        categoryId: "meat",
      ),
      ProductModel(
        id: "4",
        name: "Лосось",
        iconKey: CatalogIconsKeys.fish.name,
        unit: "шт",
        categoryId: "fish",
      ),
      ProductModel(
        id: "5",
        name: "Молоко",
        iconKey: CatalogIconsKeys.milk.name,
        unit: "л",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "6",
        name: "Хлеб",
        iconKey: CatalogIconsKeys.wheat.name,
        unit: "шт",
        categoryId: "bread",
      ),
      ProductModel(
        id: "7",
        name: "Пиво",
        iconKey: CatalogIconsKeys.beer.name,
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "8",
        name: "Салат",
        iconKey: CatalogIconsKeys.salad.name,
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "9",
        name: "Творог",
        iconKey: CatalogIconsKeys.milk.name,
        unit: "г",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "10",
        name: "Спагетти",
        iconKey: CatalogIconsKeys.salad.name,
        unit: "г",
        categoryId: "bread",
      ),
      ProductModel(
        id: "11",
        name: "Вино",
        iconKey: CatalogIconsKeys.wine.name,
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "12",
        name: "Гамбургер",
        iconKey: CatalogIconsKeys.hamburger.name,
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "13",
        name: "Сыр",
        iconKey: CatalogIconsKeys.egg.name,
        unit: "г",
        categoryId: "dairy",
      ),
    ]);
  }
}
