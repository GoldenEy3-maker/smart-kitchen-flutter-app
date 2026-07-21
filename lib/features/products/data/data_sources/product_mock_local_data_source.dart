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
        iconKey: CatalogIconsKey.broccoli.name,
      ),
      CategoryModel(
        id: "fruits",
        label: "Фрукты",
        iconKey: CatalogIconsKey.apple.name,
      ),
      CategoryModel(
        id: "meat",
        label: "Мясо",
        iconKey: CatalogIconsKey.beef.name,
      ),
      CategoryModel(
        id: "fish",
        label: "Рыба",
        iconKey: CatalogIconsKey.fish.name,
      ),
      CategoryModel(
        id: "dairy",
        label: "Молоко",
        iconKey: CatalogIconsKey.milk.name,
      ),
      CategoryModel(
        id: "bread",
        label: "Хлеб",
        iconKey: CatalogIconsKey.wheat.name,
      ),
      CategoryModel(
        id: "alcohol",
        label: "Алкоголь",
        iconKey: CatalogIconsKey.wine.name,
      ),
      CategoryModel(
        id: "other",
        label: "Другие",
        iconKey: CatalogIconsKey.package.name,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    return Right([
      ProductModel(
        id: "1",
        name: "Картофель",
        iconKey: CatalogIconsKey.broccoli.name,
        unit: "кг",
        categoryId: "vegetables",
      ),
      ProductModel(
        id: "2",
        name: "Яблоко",
        iconKey: CatalogIconsKey.apple.name,
        unit: "шт",
        categoryId: "fruits",
      ),
      ProductModel(
        id: "3",
        name: "Говядина",
        iconKey: CatalogIconsKey.beef.name,
        unit: "кг",
        categoryId: "meat",
      ),
      ProductModel(
        id: "4",
        name: "Лосось",
        iconKey: CatalogIconsKey.fish.name,
        unit: "шт",
        categoryId: "fish",
      ),
      ProductModel(
        id: "5",
        name: "Молоко",
        iconKey: CatalogIconsKey.milk.name,
        unit: "л",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "6",
        name: "Хлеб",
        iconKey: CatalogIconsKey.wheat.name,
        unit: "шт",
        categoryId: "bread",
      ),
      ProductModel(
        id: "7",
        name: "Пиво",
        iconKey: CatalogIconsKey.beer.name,
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "8",
        name: "Салат",
        iconKey: CatalogIconsKey.salad.name,
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "9",
        name: "Творог",
        iconKey: CatalogIconsKey.milk.name,
        unit: "г",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "10",
        name: "Спагетти",
        iconKey: CatalogIconsKey.salad.name,
        unit: "г",
        categoryId: "bread",
      ),
      ProductModel(
        id: "11",
        name: "Вино",
        iconKey: CatalogIconsKey.wine.name,
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "12",
        name: "Гамбургер",
        iconKey: CatalogIconsKey.hamburger.name,
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "13",
        name: "Сыр",
        iconKey: CatalogIconsKey.egg.name,
        unit: "г",
        categoryId: "dairy",
      ),
    ]);
  }
}
