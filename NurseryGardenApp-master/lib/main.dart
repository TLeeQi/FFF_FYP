import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nurserygardenapp/helper/route_helper.dart';
import 'package:nurserygardenapp/providers/auth_provider.dart';
import 'package:nurserygardenapp/providers/bidding_provider.dart';
import 'package:nurserygardenapp/providers/cart_provider.dart';
import 'package:nurserygardenapp/providers/address_provider.dart';
import 'package:nurserygardenapp/providers/customize_provider.dart';
import 'package:nurserygardenapp/providers/delivery_provider.dart';
import 'package:nurserygardenapp/providers/order_provider.dart';
import 'package:nurserygardenapp/providers/pay_provider.dart';
import 'package:nurserygardenapp/providers/plant_provider.dart';
import 'package:nurserygardenapp/providers/product_provider.dart';
import 'package:nurserygardenapp/providers/splash_provider.dart';
import 'package:nurserygardenapp/providers/user_provider.dart';
import 'package:nurserygardenapp/util/app_constants.dart';
import 'package:nurserygardenapp/util/dimensions.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'
    show LicenseEntryWithLineBreaks, LicenseRegistry, kIsWeb;
import 'di_container.dart' as di;

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.get('STRIPE_PUBLISHABLE_KEY');
  await di.init();
  EasyLoading.init();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/ROBOTO.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<PlantProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<CustomizeProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<UserProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<PayProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<AddressProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<DeliveryProvider>()),
        ChangeNotifierProvider(create: (context) => di.sl<BiddingProvider>()),
      ],
      child: MyApp(
        isWeb: !kIsWeb,
      )));
}

class MyApp extends StatefulWidget {
  final bool isWeb;

  const MyApp({Key? key, required this.isWeb}) : super(key: key);

  static final navigatorKey = new GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RouterHelper.setupRoute();
    if (kIsWeb) {
      print('using web');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child) {
        return MaterialApp(
          themeMode: ThemeMode.light,
          initialRoute: Routes.getSplashRoute(),
          onGenerateRoute: RouterHelper.router.generator,
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          navigatorKey: MyApp.navigatorKey,
          theme: light,
          scrollBehavior: MaterialScrollBehavior().copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown,
          }),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

ThemeData light = ThemeData(
  //2555,30,133
  primarySwatch: Colors.green,
  dialogTheme: DialogTheme(surfaceTintColor: Colors.white),
  appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.white, backgroundColor: Colors.white),
  drawerTheme: DrawerThemeData(
      surfaceTintColor: Colors.white, backgroundColor: Colors.white),
  useMaterial3: true,
  primaryColor: const Color.fromARGB(255, 30, 133, 104),
  primaryColorLight: const Color.fromARGB(255, 30, 133, 104).withOpacity(.5),
  brightness: Brightness.light,
  canvasColor: Colors.white,
  cardColor: Colors.white,
  focusColor: const Color(0xFFADC4C8),
  hintColor: const Color(0xFF52575C),
  scaffoldBackgroundColor: const Color(0xFFF9FAFD),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: Colors.black,
    textStyle: const TextStyle(color: Colors.black),
  )),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  textTheme: GoogleFonts.robotoTextTheme(
    TextTheme().copyWith(
      labelLarge: TextStyle(color: Colors.white),
      displayLarge: TextStyle(
          fontWeight: FontWeight.w300, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      displayMedium: TextStyle(
          fontWeight: FontWeight.w400, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      displaySmall: TextStyle(
          fontWeight: FontWeight.w500, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.w600, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.w700, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      titleLarge: TextStyle(
          fontWeight: FontWeight.w800, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w900, fontSize: Dimensions.FONT_SIZE_DEFAULT),
      titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 12.0),
      bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color.fromARGB(255, 30, 133, 104),
    selectionHandleColor: Color.fromARGB(255, 30, 133, 104),
    selectionColor: Color.fromARGB(255, 30, 133, 104),
  ),
  bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  listTileTheme: ListTileThemeData(tileColor: Colors.white),
);
