import 'dart:developer';

import 'package:food_ninja/backend/repo/UpdateProfileRepo.dart';
import 'package:food_ninja/backend/repo/getMenuListRepo.dart';
import 'package:food_ninja/backend/repo/getResturantsRepo.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getMenuListController = Provider((ref) {
  final getMenuListRepository = ref.watch(getMenuListRepo);
  return GetMenuListController(
    ref: ref,
    getMenuListEntryRepo: getMenuListRepository,
  );
});

class GetMenuListController {
  final ProviderRef ref;
  final GetMenuListEntryRepo getMenuListEntryRepo;

  GetMenuListController({
    required this.ref,
    required this.getMenuListEntryRepo,
  });

  Future<FireResponse> getMenuList() {
    return getMenuListEntryRepo.getMenuList();
  }
}
