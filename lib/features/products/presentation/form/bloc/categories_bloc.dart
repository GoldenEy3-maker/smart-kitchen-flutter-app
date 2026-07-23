import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/features/products/domain/entities/entities.dart";

part "categories_event.dart";
part "categories_state.dart";

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesState(categories: [])) {
    on<CategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
