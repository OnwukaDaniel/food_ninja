import 'package:food_ninja/backend/controllers/getRestaurantsController.dart';
import 'package:food_ninja/backend/controllers/updateProfileController.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getUserProfileFutureController = FutureProvider((ref) {
  return ref.watch(updateProfileController).getProfile();
});
