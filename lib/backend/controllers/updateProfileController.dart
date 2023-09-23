import 'dart:developer';

import 'package:food_ninja/backend/repo/UpdateProfileRepo.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateProfileController = Provider((ref) {
  final updateProfileRepository = ref.watch(updateProfileRepo);
  return UpdateProfileController(
    ref: ref,
    updateProfileEntryRepo: updateProfileRepository,
  );
});

class UpdateProfileController {
  final ProviderRef ref;
  final UpdateProfileEntryRepo updateProfileEntryRepo;

  UpdateProfileController({
    required this.ref,
    required this.updateProfileEntryRepo,
  });

  Future<FireResponse> updateProfile(UserProfile userProfile) {
    return updateProfileEntryRepo.updateProfileRepo(userProfile);
  }

  Future<FireResponse> getProfile() {
    return updateProfileEntryRepo.getUserProfile();
  }
}
