bool productionEnvironment = AppFlavor.appFlavor == Flavors.production;

enum Flavors {
  production,
  testing,
}


class AppFlavor {
  static Flavors appFlavor = Flavors.production;

  static String get title {
    switch (appFlavor) {
      case Flavors.production:
        return 'users';
      case Flavors.testing:
        return 'users';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavors.production:
      case Flavors.testing:
        return "https://reqres.in/api/";
    }
  }
}
