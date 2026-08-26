import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:smart_kitchen_flutter_app/domains/products/domain/entities/entities.dart";

part "fridge_form_event.dart";
part "fridge_form_state.dart";

class FridgeFormBloc extends Bloc<FridgeFormEvent, FridgeFormState> {
  FridgeFormBloc()
    : super(FridgeFormState(selectedExpirationDate: DateTime.now())) {
    on<FridgeFormEvent>((event, emit) {
      // TODO(Danil): implement event handler
    });
  }
}
