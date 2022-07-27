import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// {@template datapersistence_repository}
/// Repository to handle data persistence.
/// {@endtemplate}
class DatapersistenceRepository {
  /// {@macro datapersistence_repository}
  const DatapersistenceRepository();

  /// Method to initialize the repository.
  Future<void> init() async {
    final directory = await getApplicationSupportDirectory();
    if (!directory.existsSync()) {
      directory.createSync();
    }

    Hive.init(directory.path);

    await Future.wait([
      Hive.openBox<dynamic>(DatapersistenceRepository._settingBox),
    ]);
  }

  /// Method to get the settings [Box].
  Box<dynamic> get settingBox =>
      Hive.openBox<dynamic>(DatapersistenceRepository._settingBox) as Box;

  /// Method to get the language of the app.
  String? get language =>
      settingBox.get(AppSettingsKeys.language.name) as String?;

  /// Method to set the language of the app.
  Future<void> setLanguage(String language) async =>
      settingBox.put(AppSettingsKeys.language, language);

  /// The name of the app settings box.
  static const _settingBox = 'settings';
}

/// {@template app settings keys}
/// Enum with all the settings keys.
/// {@endtemplate}
enum AppSettingsKeys {
  /// Language key
  language,
}
