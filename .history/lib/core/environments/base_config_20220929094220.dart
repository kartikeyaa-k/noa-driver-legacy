import 'dart:developer';

import 'package:noa/core/environments/dev_config.dart';
import 'package:noa/core/environments/prod_config.dart';

enum EnvironmentType { dev, prod }

///Abstract class that provides the frame for defining the api url configuration
abstract class BaseConfig {
  /// type
  EnvironmentType get envType;

  /// is the api url secure
  /// true for https
  bool get isSecure;

  ///Base Url for the Api
  String get baseUrl;

  ///Api key if any
  String get apiKey;

  ///middle ware api if any
  String get middlewareUrl;

  ///connetion time out, use if only nessesary
  int get connectTimeout;

  ///reciver timeout, use if only nessesary
  int get receiveTimeout;

  ///payment gateway key
  String get paymentGatewayKey;
}

///Environment class for setting the environment of the application.
class Environment {
  ///Making Env class singleton
  factory Environment() => _environment;

  Environment._internal();

  static final Environment _environment = Environment._internal();

  ///late initializing the confing of the application
  late BaseConfig config;

  ///Available config types: DEV: development & PROD: production
  // ignore: constant_identifier_names
  static const String DEV = 'DEV';

  ///Available config types: DEV: development & PROD: production
  // ignore: constant_identifier_names
  static const String PROD = 'PROD';

  /// initializing the config of the application
  void initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        log(
          '''
this is the production config.----------Please be carefull and do not perform any actions in it''',
        );
        return ProdConfig();
      default:
        log('Application running on DEV MODE');
        return DevConfig();
    }
  }
}
