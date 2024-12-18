import 'package:package_info_plus/package_info_plus.dart';

// Utility class to manage package information
class PackageInfoUtil {
  /// Private static variable to hold package information
  static PackageInfo? _packageInfo;

  /// Asynchronous method to initialize package information
  static Future<void> init() async {
    /// Fetch package information from the platform and assign it to _packageInfo
    _packageInfo = await PackageInfo.fromPlatform();
  }

  /// Getter to retrieve the version of the package, defaults to '0.0.0' if not available
  static String get version => _packageInfo?.version ?? '';

  /// Getter to retrieve the build number of the package, defaults to '0' if not available
  static String get buildNumber => _packageInfo?.buildNumber ?? '';
}