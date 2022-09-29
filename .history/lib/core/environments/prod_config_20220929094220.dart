import 'package:noa/core/environments/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiKey => throw UnimplementedError();

  @override
  String get baseUrl => 'https://admin.noa.market/';

  @override
  int get connectTimeout => throw UnimplementedError();

  @override
  String get middlewareUrl => throw UnimplementedError();

  @override
  int get receiveTimeout => throw UnimplementedError();

  @override
  bool get isSecure => false;

  @override
  String get paymentGatewayKey =>
      'pk_live_51K40mhApHBjXKUboYHtmBVq58Mu0BR8CulGBmYTwIN5KA89Gzlo6Ij8qNemmvtwJtPJx6P1w2SG6z8hDjO0QJ8hZ00gf9QnAQt';

  @override
  EnvironmentType get envType => EnvironmentType.prod;
}
