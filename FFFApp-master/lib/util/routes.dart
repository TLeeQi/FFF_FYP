import 'dart:convert';

class Routes {
  /** ROUTE NAME **/
  static const String COMING_SOON = '/coming-soon';
  static const String SPLASH_SCREEN = '/splash';

  // Auth
  static const String LOGIN_SCREEN = '/login';
  static const String REGISTER_SCREEN = '/register';

  // Dashboard
  static const String DASHBOARD = '/';
  static const String HOME_SCREEN = '/home';
  static const String DASHBOARD_SCREEN = '/dashboard';

  // Plant
  static const String PLANT_SCREEN = '/plant';
  static const String PLANT_DETAIL_SCREEN = '/plant-detail';
  static const String PLANT_SEARCH_SCREEN = '/plant-search';
  static const String PLANT_SEARCH_RESULT_SCREEN = '/plant-search/result';

  // Product
  static const String PRODUCT_SCREEN = '/product';
  static const String PRODUCT_DETAIL_SCREEN = '/product-detail';
  static const String WIRING_DETAIL_SCREEN = '/wiring-detail';
  static const String PIPING_DETAIL_SCREEN = '/piping-detail';
  static const String GARDENING_DETAIL_SCREEN = '/gardening-detail';
  static const String RUNNER_DETAIL_SCREEN = '/runner-detail';
  static const String PRODUCT_SEARCH_SCREEN = '/product-search';
  static const String PRODUCT_SEARCH_RESULT_SCREEN = '/product-search/result';

  // Customization
  static const String CUSTOMIZATION_SCREEN = '/customization';
  static const String CUSTOMIZATION_SHOW_SCREEN = '/customization-show';
  static const String CUSTOMIZATION_CONFIRM_SCREEN = '/customization/confirm';
  static const String CUSTOMIZATION_STYLE_SCREEN = '/customization-style';

  // Cart
  static const String CART_SCREEN = '/cart';

  // Order
  static const String ORDER_SCREEN = '/order';
  static const String ORDER_DETAIL_SCREEN = '/order-detail';
  static const String ORDER_CONFIRMATION_SCREEN = '/order-confirmation';
  static const String ORDER_ADDRESS_SCREEN = '/order-address';  
  static const String ORDER_DELIVERY_SCREEN = '/order-delivery';
  static const String ORDER_RECEIPT_SCREEN = '/order-receipt';

  // Payment
  static const String PAYMENT_SCREEN = '/payment';

  // Address
  static const String ADDRESS_SCREEN = '/address';
  static const String ADD_ADDRESS_SCREEN = '/add-address';
  static const String ADDRESS_DETAIL_SCREEN = '/address-detail';

  // Bidding
  static const String BIDDING_SCREEN = '/bidding';
  static const String BIDDING_DETAIL_SCREEN = '/bidding-detail';
  static const String BIDDING_REFUND_SCREEN = '/bidding-refund';

  // Vendor
  static const String VENDOR_SCREEN = '/vendor';
  static const String VENDOR_DETAIL_SCREEN = '/vendor-detail';
  static const String VENDOR_SEARCH_SCREEN = '/vendor-search';
  static const String VENDOR_SEARCH_RESULT_SCREEN = '/vendor-search/result';

  // Delivery
  static const String DELIVERY_SCREEN = '/delivery';
  static const String DELIVERY_DETAIL_SCREEN = '/delivery-detail';
  static const String DELIVERY_RECEIPT_SCREEN = '/delivery-receipt';

  // Account
  static const String ACCOUNT_SCREEN = '/account';
  static const String PROFILE_SCREEN = '/profile';
  static const String SETTINGS_SCREEN = '/settings';
  static const String CHANGE_PASSWORD_SCREEN = '/change-password';
  static const String CHANGE_EMAIL = '/change-email';
  static const String HELP_SCREEN = '/help';
  static const String FAQS_SCREEN = '/faqs';

  // Image Widget
  static const String IMAGE_ENLARGE_SCREEN = '/image-enlarge';

  // Emergency
  static const String EMERGENCY_SCREEN = '/emergency';

  /** ROUTE **/
  static String getComingSoonRoute() => COMING_SOON;
  static String getSplashRoute() => SPLASH_SCREEN;

  // Auth
  static String getLoginRoute() => LOGIN_SCREEN;
  static String getRegisterRoute() => REGISTER_SCREEN;

  // Dashboard
  static String getHomeRoute() => HOME_SCREEN;
  static String getMainRoute() => DASHBOARD;
  static String getDashboardRoute(String page) =>
      '$DASHBOARD_SCREEN?page=$page';

  // Emergency
  // static String getEmergencyRoute() => EMERGENCY_SCREEN;

  // Plant
  static String getPlantRoute() => PLANT_SCREEN;
  static String getPlantDetailRoute(
          String plantID, String isSearch, String isCart) =>
      '$PLANT_DETAIL_SCREEN?plantID=$plantID&isSearch=$isSearch&isCart=$isCart';
  static String getPlantSearchRoute() => PLANT_SEARCH_SCREEN;
  static String getPlantSearchResultRoute(String searchKeyword) =>
      '$PLANT_SEARCH_RESULT_SCREEN?searchKeyword=$searchKeyword';

  // Product
  static String getProductRoute() => PRODUCT_SCREEN;
  static String getProductDetailRoute(
          String productID, String isSearch, String isCart) =>
      '$PRODUCT_DETAIL_SCREEN?productID=$productID&isSearch=$isSearch&isCart=$isCart';
  static String getWiringDetailRoute(
          String productID, String isSearch, String isCart) =>
      '$WIRING_DETAIL_SCREEN?productID=$productID&isSearch=$isSearch&isCart=$isCart';
  static String getPipingDetailRoute(
          String productID, String isSearch, String isCart) =>
      '$PIPING_DETAIL_SCREEN?productID=$productID&isSearch=$isSearch&isCart=$isCart';
  static String getGardeningDetailRoute(
          String productID, String isSearch, String isCart) =>
      '$GARDENING_DETAIL_SCREEN?productID=$productID&isSearch=$isSearch&isCart=$isCart';
  static String getRunnerDetailRoute(
          String productID, String isSearch, String isCart) =>
      '$RUNNER_DETAIL_SCREEN?productID=$productID&isSearch=$isSearch&isCart=$isCart';
  static String getProductSearchRoute() => PRODUCT_SEARCH_SCREEN;
  static String getProductSearchResultRoute(String searchKeyword) =>
      '$PRODUCT_SEARCH_RESULT_SCREEN?searchKeyword=$searchKeyword';

  // Customization
  static String getCustomizationRoute() => CUSTOMIZATION_SCREEN;
  static String getCustomizationShowRoute() => CUSTOMIZATION_SHOW_SCREEN;
  static String getCustomizeConfirmationRoute() => CUSTOMIZATION_CONFIRM_SCREEN;
  static String getCustomizeStyleRoute() => CUSTOMIZATION_STYLE_SCREEN;

  // Cart
  static String getCartRoute() => CART_SCREEN;

  // Order
  static String getOrderRoute() => ORDER_SCREEN;
  static String getOrderDetailRoute(String orderID) =>
      '$ORDER_DETAIL_SCREEN?orderID=$orderID';
  static String getOrderConfirmationRoute(
    String comeFrom, 
    {bool isWiring = false, bool isPiping = false, bool isGardening = false, bool isRunner = false, 
    required Map<String, dynamic> detailData} // Ensure detailData is included in the parameters
  ) {print("Detail Data Encoded: ${jsonEncode(detailData)}"); 
    return '$ORDER_CONFIRMATION_SCREEN?comeFrom=$comeFrom'
      '&isWiring=$isWiring'
      '&isPiping=$isPiping'
      '&isGardening=$isGardening'
      '&isRunner=$isRunner'
      '&detailData=${Uri.encodeComponent(jsonEncode(detailData))}';
    }
// static String getOrderConfirmationRoute
// (String comeFrom, {bool isWiring = false, bool isPiping = false, bool isGardening = false, bool isRunner = false}, Map<String, dynamic> detailData)=> 
// // {
//     // String route = ORDER_CONFIRMATION_SCREEN;
//     // if (isWiring) {
//     //   route = ORDER_CONFIRMATION_SCREEN_WIRING;
//     // } else if (isPiping) {
//     //   route = ORDER_CONFIRMATION_SCREEN_PIPING;
//     // } else if (isGardening) {
//     //   route = ORDER_CONFIRMATION_SCREEN_GARDENING;
//     // } else if (isRunner) {
//     //   route = ORDER_CONFIRMATION_SCREEN_RUNNER;
//     // }
//     // return 
//     '$ORDER_CONFIRMATION_SCREEN?comeFrom=$comeFrom&detailData=$detailData';
//   // }
  static String getOrderAddressRoute() => ORDER_ADDRESS_SCREEN;
  static String getOrderDeliveryRoute(String orderID) =>
      '$ORDER_DELIVERY_SCREEN?orderID=$orderID';
  static String getOrderReceiptRoute(String orderID) =>
      '$ORDER_RECEIPT_SCREEN?orderID=$orderID';

  // Payment
  static String getPaymentRoute(String paymentType, String orderID) =>
      '$PAYMENT_SCREEN?paymentType=$paymentType&orderID=$orderID';

  // Address
  static String getAddressRoute() => ADDRESS_SCREEN;
  static String getAddressDetailRoute(String addressID) =>
      '$ADDRESS_DETAIL_SCREEN?addressID=$addressID';
  static String getAddAddressRoute() => ADD_ADDRESS_SCREEN;

  // Delivery
  static String getDeliveryRoute() => DELIVERY_SCREEN;
  static String getDeliveryDetailRoute(String deliveryID) =>
      '$DELIVERY_DETAIL_SCREEN?deliveryID=$deliveryID';
  static String getDeliveryReceiptRoute(String deliveryID) =>
      '$DELIVERY_RECEIPT_SCREEN?deliveryID=$deliveryID';

  // Bidding
  // static String getBiddingRoute() => BIDDING_SCREEN;
  // static String getBiddingDetailRoute(String biddingID) =>
  //     '$BIDDING_DETAIL_SCREEN?biddingID=$biddingID';
  // static String getBiddingRefundRoute() => BIDDING_REFUND_SCREEN;

  // Vendor
  static String getVendorRoute() => VENDOR_SCREEN;
  // static String getVendorDetailRoute(String vendorID) =>
  //     '$VENDOR_DETAIL_SCREEN?vendorID=$vendorID';
  static String getVendorDetailRoute(
          String vendorID, String isSearch, String isCart) =>
      '$VENDOR_DETAIL_SCREEN?vendorID=$vendorID&isSearch=$isSearch&isCart=$isCart';
  static String getVendorSearchRoute() => VENDOR_SEARCH_SCREEN;
  static String getVendorSearchResultRoute(String searchKeyword) =>
      '$VENDOR_SEARCH_RESULT_SCREEN?searchKeyword=$searchKeyword';

  // Image widget
  static String getImageEnlargeRoute(String tag, String url) =>
      '$IMAGE_ENLARGE_SCREEN?tag=$tag&url=$url';

  // Account
  static String getAcocuntRoute() => ACCOUNT_SCREEN;
  static String getProfileRoute() => PROFILE_SCREEN;
  static String getSettingsRoute() => SETTINGS_SCREEN;
  static String getChangePasswordRoute() => CHANGE_PASSWORD_SCREEN;
  static String getChangeEmailRoute() => CHANGE_EMAIL;
  static String getHelpRoute() => HELP_SCREEN;
  static String getFAQsRoute() => FAQS_SCREEN;
}
