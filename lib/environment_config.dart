class EnvironmentConfig {
  static const isProd = String.fromEnvironment('isProd', defaultValue: 'false');
}
