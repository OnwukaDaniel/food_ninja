import 'package:food_ninja/backend/controllers/getRestaurantsController.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getRestaurantFutureController = FutureProvider((ref) {
  return ref.watch(getRestaurantsController).getRestaurants();
});
