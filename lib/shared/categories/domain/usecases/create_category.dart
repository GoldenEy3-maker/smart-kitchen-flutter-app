import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/entities/entities.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/shared/categories/params/params.dart";

class CreateCategory implements UseCase<Category, CreateCategoryParams> {
  final CategoriesRepository _repository;

  CreateCategory({required this._repository});

  @override
  Future<Either<Failure, Category>> call(CreateCategoryParams params) {
    return _repository.createCategory(params);
  }
}
