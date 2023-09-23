import 'package:flutter/material.dart';
import 'package:food_ninja/models/ChatData.dart';
import 'package:food_ninja/models/UserProfile.dart';
import 'package:food_ninja/models/Voucher.dart';
import 'package:food_ninja/theme/apptheme.dart';

import '../globals/search_filter_type.dart';
import '../models/FoodMenu.dart';

ValueNotifier<ThemeData> appTheme = ValueNotifier(AppTheme.lightTheme);
ValueNotifier<List<String>> restaurantList = ValueNotifier([]);

ValueNotifier<int> typeVN = ValueNotifier(SearchFilterType.RESTAURANT);
ValueNotifier<int> locationVN = ValueNotifier(SearchFilterType.ONEKM);
ValueNotifier<List<int>> foodVN = ValueNotifier([]);
ValueNotifier<int> homeBackStackCounterVN = ValueNotifier(0);
ValueNotifier<List<Voucher>> voucherVN = ValueNotifier([]);
ValueNotifier<List<FoodMenu>> favouriteVN = ValueNotifier([
  FoodMenu(
    images: [
      "https://firebasestorage.googleapis.com/v0/b/food-ninja-cb271"
          ".appspot.com/o/food_menu%2FNkHcnacaAce.png?alt=media&token=7eadd396-0e1a-41bf-9920-5a394813c73d"
    ],
    name: "Food name",
    currency: "\$",
    desc: "Tasty fried chicken",
    price: 120,
  ),
  FoodMenu(
    images: [
      "https://firebasestorage.googleapis.com/v0/b/food-ninja-cb271"
          ".appspot.com/o/food_menu%2FNkHcnacaAce.png?alt=media&token=7eadd396-0e1a-41bf-9920-5a394813c73d"
    ],
    name: "African Salad",
    currency: "\$",
    desc: "Salad",
    price: 420,
  ),
  FoodMenu(
    images: [
      "https://firebasestorage.googleapis.com/v0/b/food-ninja-cb271"
          ".appspot.com/o/food_menu%2FNkHcnacaAce.png?alt=media&token=7eadd396-0e1a-41bf-9920-5a394813c73d"
    ],
    name: "Crunchy chips",
    currency: "\$",
    desc: "Chips",
    price: 500,
  ),
  FoodMenu(
    images: [
      "https://firebasestorage.googleapis.com/v0/b/food-ninja-cb271"
          ".appspot.com/o/food_menu%2FNkHcnacaAce.png?alt=media&token=7eadd396-0e1a-41bf-9920-5a394813c73d"
    ],
    name: "Food name",
    currency: "\$",
    desc: "Tasty fried chicken",
    price: 500,
  ),
  FoodMenu(
    images: [
      "https://firebasestorage.googleapis.com/v0/b/food-ninja-cb271"
          ".appspot.com/o/food_menu%2FNkHcnacaAce.png?alt=media&token=7eadd396-0e1a-41bf-9920-5a394813c73d"
    ],
    name: "Food name",
    currency: "\$",
    desc: "Tasty fried chicken",
    price: 120,
  ),
]);
ValueNotifier<UserProfile> userProfileVN = ValueNotifier(UserProfile());

ValueNotifier<List<ChatData>> chatListVN = ValueNotifier([
  ChatData(
    message: "Hello",
    uid: "4pY6P0PYxxclBG57z2wBPnca1hB2",
    uids: ["4pY6P0PYxxclBG57z2wBPnca1hB2"],
    time: "1039992093029",
  ),
  ChatData(
    message: "How are you! Hello",
    uid: "4pY6P0PYxxclBG57z2wBPnca1hB2",
    uids: ["4pY6P0PYxxclBG57z2wBPnca1hB2"],
    time: "1039992093029",
  ),
  ChatData(
    message: "Dear! Hello",
    uid: "4pY6P0PYxxclBG57z2wBPnca1hB2",
    uids: ["4pY6P0PYxxclBG57z2wBPnca1hB2"],
    time: "1039992093029",
  ),
  ChatData(
    message: "Social data",
    uid: "4pY6P0PYxxclBG57z2wBPnca1hB2",
    uids: ["4pY6P0PYxxclBG57z2wBPnca1hB2"],
    time: "1039992093029",
  ),
  ChatData(
    message: "Hello",
    uid: "4pY6P0PYxxclBG57z2wBPnca1hB2",
    uids: ["4pY6P0PYxxclBG57z2wBPnca1hB2"],
    time: "1039992093029",
  ),
]);
