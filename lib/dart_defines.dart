// ignore: avoid_classes_with_only_static_members

/// List of parameters passed by `--dart-define` at runtime.
class DartDefines {
  /// Environment type used in [Env].The acceptable values ​​are:
  ///
  /// - develop
  /// - staging
  static const String flavor = String.fromEnvironment(
    'flavor',
    defaultValue: 'develop',
  );
}
