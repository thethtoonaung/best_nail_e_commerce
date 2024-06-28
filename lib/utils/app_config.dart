class AppConfig {
  static String appName = "Best ";
  static String appTagLine = "Nail Supply";
  static String storeId = "13";
  static String appLogo = "assets/img/appLogo2.jpg";
}

enum AppLanguage {
  en(desc: "English"),
  mm(desc: "မြန်မာ");

  final String desc;
  const AppLanguage({required this.desc});
}
