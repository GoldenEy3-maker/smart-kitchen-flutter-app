import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/domains/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/domains/categories/params/params.dart";

class UpdateCategory implements UseCase<Category, UpdateCategoryParams> {
  final CategoriesRepository _repository;

  UpdateCategory({required this._repository});

  @override
  Future<Either<Failure, Category>> call(UpdateCategoryParams params) {
    return _repository.updateCategory(params);
  }
}
