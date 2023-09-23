import 'dart:developer';

import 'package:food_ninja/backend/repo/AddToCartRepo.dart';
import 'package:food_ninja/backend/repo/UpdateProfileRepo.dart';
import 'package:food_ninja/backend/response/fire_response.dart';
import 'package:food_ninja/models/FoodMenu.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addToCartController = Provider((ref) {
  final addToCartRepository = ref.watch(addToCartRepo);
  return AddToCartController(
    ref: ref,
    addToCartEntryRepo: addToCartRepository,
  );
});

class AddToCartController {
  final ProviderRef ref;
  final AddToCartEntryRepo addToCartEntryRepo;

  AddToCartController({
    required this.ref,
    required this.addToCartEntryRepo,
  });

  Future<FireResponse> addToCart(FoodMenu foodMenu) {
    return addToCartEntryRepo.addToCart(foodMenu);
  }
}
