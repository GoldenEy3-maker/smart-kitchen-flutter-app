import "package:smart_kitchen_flutter_app/core/error/error.dart";
import "package:smart_kitchen_flutter_app/core/utils/utils.dart";

/// Application-specific business rules.
///
/// Presentation must depend on use cases, not repositories directly.
/// Thin delegates are intentional: they keep a stable boundary and a single
/// place for validation, orchestration, or side effects before/after data access.
// ignore: one_member_abstracts
abstract interface class UseCase<ResultType, Params> {
  Future<Either<Failure, ResultType>> call(Params params);
}

final class NoParams {
  const NoParams();
}
