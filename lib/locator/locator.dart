import 'package:get_it/get_it.dart';
import 'package:noa_driver/core/repositories/delivery_address_repository.dart';
import 'package:noa_driver/http-service/http-service.dart';
import 'package:noa_driver/login-registration/login-repository.dart';
import 'package:noa_driver/order-details/order-repository.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<HttpService>(() => HttpService());
  locator.registerLazySingleton<LoginRepository>(() => LoginRepository());
  locator.registerLazySingleton<OrderRepository>(() => OrderRepository());

  // LATEST
  // CONTACT KARTIKEYA
  locator.registerLazySingleton<DeliveryAddressRepository>(
      () => DeliveryAddressRepository());
}
