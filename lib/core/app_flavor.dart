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
        return "http://13.50.207.200/api/";
        return "http://16.171.110.113/api/";
        return "http://51.20.86.237:8000/api/";
        return "http://10.0.2.2:8000/api/"; //10.0.2.2
    }
  }
}
