import 'package:dio/dio.dart';
import 'package:FFF/data/dio/login_interceptor.dart';
import 'package:FFF/data/repositories/address_repo.dart';
import 'package:FFF/data/repositories/bidding_repo.dart';
import 'package:FFF/data/repositories/cart_repo.dart';
import 'package:FFF/data/repositories/customize_repo.dart';
import 'package:FFF/data/repositories/delivery_repo.dart';
import 'package:FFF/data/repositories/order_repo.dart';
import 'package:FFF/data/repositories/pay_repo.dart';
import 'package:FFF/data/repositories/plant_repo.dart';
import 'package:FFF/data/repositories/product_repo.dart';
import 'package:FFF/data/repositories/splash_repo.dart';
import 'package:FFF/data/repositories/user_repo.dart';
import 'package:FFF/providers/auth_provider.dart';
import 'package:FFF/providers/bidding_provider.dart';
import 'package:FFF/providers/cart_provider.dart';
import 'package:FFF/providers/address_provider.dart';
import 'package:FFF/providers/customize_provider.dart';
import 'package:FFF/providers/delivery_provider.dart';
import 'package:FFF/providers/order_provider.dart';
import 'package:FFF/providers/pay_provider.dart';
import 'package:FFF/providers/plant_provider.dart';
import 'package:FFF/providers/product_provider.dart';
import 'package:FFF/providers/splash_provider.dart';
import 'package:FFF/providers/user_provider.dart';
import 'package:FFF/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FFF/providers/vendor_provider.dart';
// import 'package:FFF/providers/wiring_provider.dart';
// import 'package:FFF/providers/wiringdetail_provider.dart';
import 'package:FFF/data/repositories/vendor_repo.dart';
// import 'package:FFF/data/repositories/wiring_repo.dart';

import 'package:get_it/get_it.dart';
import 'data/dio/dio_client.dart';
import 'data/repositories/auth_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URI, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => PlantRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => ProductRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => CustomizeRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => CartRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => OrderRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => PayRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => UserRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => AddressRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => DeliveryRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => BiddingRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => VendorRepo(dioClient: sl(), sharedPreferences: sl()));
  // sl.registerLazySingleton(
  //     () => WiringRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(
      () => PlantProvider(plantRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => ProductProvider(productRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => CustomizeProvider(customizeRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => CartProvider(cartRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => OrderProvider(orderRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
    () => PayProvider(payRepo: sl(), sharedPreferences: sl()),
  );
  sl.registerFactory(
      () => UserProvider(userRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => AddressProvider(addressRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => DeliveryProvider(deliveryRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => BiddingProvider(biddingRepo: sl(), sharedPreferences: sl()));
  sl.registerFactory(
      () => VendorProvider(vendorRepo: sl(), sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
