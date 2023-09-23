import 'package:food_ninja/backend/controllers/getMenuListController.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getMenuListFutureController = FutureProvider((ref) {
  return ref.watch(getMenuListController).getMenuList();
});
