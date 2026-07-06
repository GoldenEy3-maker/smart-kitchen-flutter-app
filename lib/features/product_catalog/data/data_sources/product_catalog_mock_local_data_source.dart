import "package:smart_kitchen_flutter_app/core/error/failure.dart";

import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/features/product_catalog/data/models/models.dart";

import "product_catalog_local_data_source.dart";

class ProductCatalogMockLocalDataSource
    implements ProductCatalogLocalDataSource {
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    return Right([
      CategoryModel(id: "vegetables", label: "Овощи", emoji: "🥬"),
      CategoryModel(id: "fruits", label: "Фрукты", emoji: "🍎"),
      CategoryModel(id: "meat", label: "Мясо", emoji: "🍖"),
      CategoryModel(id: "fish", label: "Рыба", emoji: "🍣"),
      CategoryModel(id: "dairy", label: "Молоко", emoji: "🥛"),
      CategoryModel(id: "bread", label: "Хлеб", emoji: "🍞"),
      CategoryModel(id: "alcohol", label: "Алкоголь", emoji: "🍺"),
      CategoryModel(id: "other", label: "Другие", emoji: "🍽"),
    ]);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    return Right([
      ProductModel(
        id: "1",
        name: "Картофель",
        emoji: "🥦",
        unit: "кг",
        categoryId: "vegetables",
      ),
      ProductModel(
        id: "2",
        name: "Яблоко",
        emoji: "🍎",
        unit: "шт",
        categoryId: "fruits",
      ),
      ProductModel(
        id: "3",
        name: "Говядина",
        emoji: "🍖",
        unit: "кг",
        categoryId: "meat",
      ),
      ProductModel(
        id: "4",
        name: "Лосось",
        emoji: "🍣",
        unit: "шт",
        categoryId: "fish",
      ),
      ProductModel(
        id: "5",
        name: "Молоко",
        emoji: "🥛",
        unit: "л",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "6",
        name: "Хлеб",
        emoji: "🍞",
        unit: "шт",
        categoryId: "bread",
      ),
      ProductModel(
        id: "7",
        name: "Пиво",
        emoji: "🍺",
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "8",
        name: "Салат",
        emoji: "🍽",
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "9",
        name: "Творог",
        emoji: "🥛",
        unit: "г",
        categoryId: "dairy",
      ),
      ProductModel(
        id: "10",
        name: "Спагетти",
        emoji: "🍝",
        unit: "г",
        categoryId: "bread",
      ),
      ProductModel(
        id: "11",
        name: "Вино",
        emoji: "🍷",
        unit: "л",
        categoryId: "alcohol",
      ),
      ProductModel(
        id: "12",
        name: "Гамбургер",
        emoji: "🍔",
        unit: "шт",
        categoryId: "other",
      ),
      ProductModel(
        id: "13",
        name: "Сыр",
        emoji: "🥛",
        unit: "г",
        categoryId: "dairy",
      ),
    ]);
  }
}
