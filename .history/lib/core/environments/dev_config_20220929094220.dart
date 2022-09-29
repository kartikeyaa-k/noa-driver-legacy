import 'package:noa/core/environments/base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get apiKey => throw UnimplementedError();

  @override
  String get baseUrl => 'http://3.28.195.139:8080/';

  @override
  int get connectTimeout => throw UnimplementedError();

  @override
  String get middlewareUrl => throw UnimplementedError();

  @override
  int get receiveTimeout => throw UnimplementedError();

  @override
  bool get isSecure => true;

  @override
  String get paymentGatewayKey =>
      'pk_test_51K40mhApHBjXKUboI0jAPiopPpd3LPFruqpcpY57PZrFlItEpKOlXKuU5NB2FNbS2WQuLT5aZS4PFxJzgEbIYfsb00WTn3CYQO';

  @override
  EnvironmentType get envType => EnvironmentType.dev;
}
