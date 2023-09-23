class SearchFilterType {
  static const int RESTAURANT = 10;
  static const int MENU = 20;

  static const int ONEKM = 30;
  static const int GONEKM = 40;
  static const int LONEKM = 50;

  static const int CAKE = 60;
  static const int SOUP = 70;
  static const int MAIN_COURSE = 80;
  static const int APPETIZER = 90;
  static const int DESSERT = 100;

  static String filterText(int input) {
    switch (input) {
      case RESTAURANT:
        return "Restaurant";
      case MENU:
        return "Menu";
      case ONEKM:
        return "1 KM";
      case GONEKM:
        return "> 1Km";
      case LONEKM:
        return "< 1Km>";
      case CAKE:
        return "Cake";
      case SOUP:
        return "Soup";
      case MAIN_COURSE:
        return "Main Course";
      case APPETIZER:
        return "Appetizer";
      case DESSERT:
        return "Dessert";
    }
    return "";
  }
}
