import '../model/settings.dart';
import '../resources/local_provider.dart';

class SettingsRepository {
  factory SettingsRepository() => _instance;

  SettingsRepository._();

  static final SettingsRepository _instance = SettingsRepository._();

  final LocalProvider _localProvider = LocalProvider();

  Future<Settings> getSettings() async {
    return await _localProvider.get<Settings>();
  }

  Future<void> upsert(Settings settings) async {
    await _localProvider.upsert<Settings>(settings);
  }
}
