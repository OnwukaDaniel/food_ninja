import 'dart:developer';

import 'package:food_ninja/backend/repo/UpdateProfileRepo.dart';
import 'package:food_ninja/backend/repo/getResturantsRepo.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getRestaurantsController = Provider((ref) {
  final getRestaurantsRepository = ref.watch(getRestaurantsRepo);
  return GetRestaurantsController(
    ref: ref,
    getRestaurantsEntryRepo: getRestaurantsRepository,
  );
});

class GetRestaurantsController {
  final ProviderRef ref;
  final GetRestaurantsEntryRepo getRestaurantsEntryRepo;

  GetRestaurantsController({
    required this.ref,
    required this.getRestaurantsEntryRepo,
  });

  Future<FireResponse> getRestaurants() {
    return getRestaurantsEntryRepo.getRestaurants();
  }
}
