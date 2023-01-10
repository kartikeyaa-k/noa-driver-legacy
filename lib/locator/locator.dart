import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:noa_driver/core/environments/base_config.dart';
import 'package:noa_driver/core/environments/server_config.dart';
import 'package:noa_driver/core/repositories/delivery_address_repository.dart';
import 'package:noa_driver/http-service/http-service.dart';
import 'package:noa_driver/login-registration/login-repository.dart';
import 'package:noa_driver/order-details/order-repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<HttpService>(() => HttpService(
        networkClient: Dio(),
        serverConfig: ServerConfig(
          isHttps: Environment().config.isSecure,
          baseUrl: Environment().config.baseUrl,
        ),
        logger: Logger(),
      ));

  locator.registerLazySingleton<LoginRepository>(() => LoginRepository());
  locator.registerLazySingleton<OrderRepository>(() => OrderRepository());

  // LATEST
  // CONTACT KARTIKEYA
  locator.registerLazySingleton<DeliveryAddressRepository>(
      () => DeliveryAddressRepository());
}
