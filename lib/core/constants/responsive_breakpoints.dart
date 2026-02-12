enum DeviceType { mobile, tablet, desktop }

class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  static const double desktop = 1024;
  static const double mobile = 600;

  static DeviceType deviceType(double width) {
    if (width < mobile) {
      return DeviceType.mobile;
    }
    if (width <= desktop) {
      return DeviceType.tablet;
    }
    return DeviceType.desktop;
  }

  static bool isMobile(double width) => width < mobile;

  static bool isTablet(double width) => width >= mobile && width <= desktop;

  static bool isDesktop(double width) => width > desktop;
}
