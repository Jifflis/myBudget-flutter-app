import '../model/settings.dart';
import '../resources/local_provider.dart';

class SettingsRepository {
  SettingsRepository._();

  static SettingsRepository _instance;
  final LocalProvider _localProvider = LocalProvider();

  static SettingsRepository get instance => _instance ?? SettingsRepository._();

  Future<Settings> getSettings() async {
    return await _localProvider.get<Settings>();
  }

  Future<void> upsert(Settings settings)async{
    await _localProvider.upsert<Settings>(settings);
  }

}
