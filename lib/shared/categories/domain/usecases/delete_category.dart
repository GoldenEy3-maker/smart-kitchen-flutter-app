import "package:smart_kitchen_flutter_app/core/error/failure.dart";
import "package:smart_kitchen_flutter_app/core/usecase/usecase.dart";
import "package:smart_kitchen_flutter_app/core/utils/either.dart";
import "package:smart_kitchen_flutter_app/shared/categories/domain/repositories/repositories.dart";
import "package:smart_kitchen_flutter_app/shared/categories/params/params.dart";

class DeleteCategory implements UseCase<void, DeleteCategoryParams> {
  final CategoriesRepository _repository;

  DeleteCategory({required this._repository});

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParams params) {
    return _repository.deleteCategory(params);
  }
}
