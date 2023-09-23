import 'dart:developer';

import 'package:food_ninja/backend/repo/UpdateProfileRepo.dart';
import 'package:food_ninja/backend/repo/getResturantMenuRepo.dart';
import 'package:food_ninja/backend/repo/getResturantsRepo.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getRestaurantMenuController = Provider((ref) {
  final getRestaurantMenuRepository = ref.watch(getRestaurantMenuRepo);
  return GetRestaurantMenuController(
    ref: ref,
    getRestaurantMenuEntryRepo: getRestaurantMenuRepository,
  );
});

class GetRestaurantMenuController {
  final ProviderRef ref;
  final GetRestaurantMenuEntryRepo getRestaurantMenuEntryRepo;

  GetRestaurantMenuController({
    required this.ref,
    required this.getRestaurantMenuEntryRepo,
  });

  Future<FireResponse> getRestaurantMenu(String resId) {
    return getRestaurantMenuEntryRepo.getRestaurantMenu(resId);
  }
}
