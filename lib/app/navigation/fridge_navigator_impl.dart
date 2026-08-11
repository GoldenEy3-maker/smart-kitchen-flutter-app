import "package:smart_kitchen_flutter_app/app/router/app_router.dart";
import "package:smart_kitchen_flutter_app/domains/fridge/navigation/navigation.dart";

class FridgeNavigatorImpl implements FridgeNavigator {
  FridgeNavigatorImpl({required this._router});

  final AppRouter _router;

  @override
  void openFridgeForm() {
    _router.push(FridgeFormRoute());
  }
}
