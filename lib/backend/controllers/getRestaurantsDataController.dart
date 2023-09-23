import 'dart:developer';

import 'package:food_ninja/backend/repo/UpdateProfileRepo.dart';
import 'package:food_ninja/backend/repo/getResturantsDataRepo.dart';
import 'package:food_ninja/backend/repo/getResturantsRepo.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getRestaurantsDataController = Provider((ref) {
  final getRestaurantsDataRepository = ref.watch(getRestaurantsDataRepo);
  return GetRestaurantsDataController(
    ref: ref,
    getRestaurantsDataEntryRepo: getRestaurantsDataRepository,
  );
});

class GetRestaurantsDataController {
  final ProviderRef ref;
  final GetRestaurantsDataEntryRepo getRestaurantsDataEntryRepo;

  GetRestaurantsDataController({
    required this.ref,
    required this.getRestaurantsDataEntryRepo,
  });

  Future<FireResponse> getRestaurantsData(String key) {
    return getRestaurantsDataEntryRepo.getRestaurantsData(key);
  }
}
