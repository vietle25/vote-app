class PlatformType {
  static final common = 0;
  static final web = 1;
  static final android = 2;
  static const ios = 3;

  static int getValue(String type) {
    switch (type) {
      case "web":
        return web;
      case "android":
        return android;
      case "ios":
        return ios;
      default:
        return common;
    }
  }
}
