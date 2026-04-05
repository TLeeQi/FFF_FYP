// import 'dart:ffi';

import 'package:fluro/fluro.dart';
import 'package:FFF/util/routes.dart';
import 'package:FFF/view/base/image_enlarge_widget.dart';
import 'package:FFF/view/screen/account/account_screen.dart';
import 'package:FFF/view/screen/account/sub_screen/changes_email_screen.dart';
//import 'package:FFF/view/screen/account/sub_screen/changes_password_screen.dart';
import 'package:FFF/view/screen/account/sub_screen/faq_screen.dart';
import 'package:FFF/view/screen/account/sub_screen/help_screen.dart';
import 'package:FFF/view/screen/account/sub_screen/profile_screen.dart';
import 'package:FFF/view/screen/account/sub_screen/settings_screen.dart';
import 'package:FFF/view/screen/address/address_screen.dart';
import 'package:FFF/view/screen/address/sub_screen/add_address_screen.dart';
import 'package:FFF/view/screen/address/sub_screen/address_detail_screen.dart';
import 'package:FFF/view/screen/auth/login_screen.dart';
import 'package:FFF/view/screen/auth/register_screen.dart';
// import 'package:FFF/view/screen/bidding/bidding_screen.dart';
// import 'package:FFF/view/screen/bidding/sub_screen/bidding_detail_screen.dart';
// import 'package:FFF/view/screen/bidding/sub_screen/bidding_refund_screen.dart';
import 'package:FFF/view/screen/cart/cart_screen.dart';
import 'package:FFF/view/screen/customization/sub_screen/customConfirmation_screen.dart';
import 'package:FFF/view/screen/customization/customization_screen.dart';
import 'package:FFF/view/screen/customization/sub_screen/custom_style_screen.dart';
import 'package:FFF/view/screen/customization/sub_screen/show_custom_screen.dart';
import 'package:FFF/view/screen/dashboard/dashboard_screen.dart';
import 'package:FFF/view/screen/delivery/delivery_screen.dart';
import 'package:FFF/view/screen/delivery/sub_screen/delivery_detail_screen.dart';
import 'package:FFF/view/screen/delivery/sub_screen/delivery_receipt_screen.dart';
import 'package:FFF/view/screen/home/home_screen.dart';
import 'package:FFF/view/screen/order/order_screen.dart';
import 'package:FFF/view/screen/order/sub_screen/order_address_screen.dart';
import 'package:FFF/view/screen/order/sub_screen/order_confirmation_screen.dart';
import 'package:FFF/view/screen/order/sub_screen/order_delivery_list.dart';
import 'package:FFF/view/screen/order/sub_screen/order_detail_screen.dart';
import 'package:FFF/view/screen/order/sub_screen/order_receipt_screen.dart';
import 'package:FFF/view/screen/payment/payment_screen.dart';
import 'package:FFF/view/screen/plant/plant_detail_screen.dart';
import 'package:FFF/view/screen/plant/plant_screen.dart';
import 'package:FFF/view/screen/plant/plant_search_result_screen.dart';
import 'package:FFF/view/screen/plant/widget/plant_search_screen.dart';
import 'package:FFF/view/screen/product/product_detail_screen.dart';
import 'package:FFF/view/screen/product/wiring_detail_screen.dart';
import 'package:FFF/view/screen/product/piping_detail_screen.dart';
import 'package:FFF/view/screen/product/gardening_detail_screen.dart';
import 'package:FFF/view/screen/product/runner_detail_screen.dart';
import 'package:FFF/view/screen/product/product_screen.dart';
import 'package:FFF/view/screen/product/product_search_result_screen.dart';
import 'package:FFF/view/screen/product/widget/product_search_screen.dart';
import 'package:FFF/view/screen/splash/splash_screen.dart';
import 'dart:convert'; 
import 'package:FFF/view/screen/vendor/vendor_detail_screen.dart';
import 'package:FFF/view/screen/vendor/vendor_screen.dart';
import 'package:FFF/view/screen/vendor/widget/vendor_search_screen.dart';
import 'package:FFF/view/screen/vendor/vendor_search_result_screen.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  static Handler _splashHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) => SplashScreen());

  /// =================================Auth=========================================
  static Handler _loginHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> parameters) => LoginScreen());

  static Handler _registerHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> parameters) =>
          RegisterScreen());

  static Handler _dashboardHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          DashboardScreen(pageIndex: 0));

  static Handler _dashScreenBoardHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> params) {
    return DashboardScreen(
        pageIndex: params['page'][0] == 'Plant'
            ? 0
            : params['page'][0] == 'Product'
                ? 1
                : params['page'][0] == 'Customization'
                    ? 2
                    : params['page'][0] == 'Vendors'
                        ? 3
                        : params['page'][0] == 'Account'
                            ? 4
                            : 0);
  });

  static Handler _homeHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => HomeScreen(),
  );

  // =================================Plant=========================================
  static Handler _plantHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => PlantScreen(),
  );

  static Handler _plantDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => PlantDetailScreen(
      plantID: params['plantID'][0],
      isSearch: params['isSearch'][0],
      isCart: params['isCart'][0],
    ),
  );

  static Handler _plantSearchHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        PlantSearchScreen(),
  );

  static Handler _plantSearchResultHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        PlantSearchResultScreen(searchKeyword: parameters['searchKeyword'][0]),
  );

  // =================================Product=========================================
  static Handler _productHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => ProductScreen(),
  );

  static Handler _productDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => ProductDetailScreen(
      productID: params['productID'][0],
      isSearch: params['isSearch'][0],
      isCart: params['isCart'][0],
    ),
  );

   static Handler _wiringDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => WiringDetailScreen(
      productID: params['productID'][0],
      isSearch: params['isSearch'][0],
      isCart: params['isCart'][0],
    ),
  );

  static Handler _pipingDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => PipingDetailScreen(
      productID: params['productID'][0],
      isSearch: params['isSearch'][0],
      isCart: params['isCart'][0],
    ),
  );

  static Handler _gardeningDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => GardeningDetailScreen(
      productID: params['productID'][0],
      isSearch: params['isSearch'][0],
      isCart: params['isCart'][0],
    ),
  );

  static Handler _runnerDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> params) => RunnerDetailScreen(
      productID: params['productID'][0],
      isSearch: params['isSearch'][0],
      isCart: params['isCart'][0],
    ),
  );

  static Handler _productSearchHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        ProductSearchScreen(),
  );

  static Handler _productSearchResultHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        ProductSearchResultScreen(
            searchKeyword: parameters['searchKeyword'][0]),
  );

  // =================================Customization=========================================
  static Handler _customizationHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> parameters) =>
          CustomizationScreen());

  static Handler _customizationShowHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> parameters) =>
          ShowCustomScreen());

  static Handler _customizationConfirmHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> parameters) =>
          CustomConfirmationScreen());

  static Handler _customizationStyleHandler = Handler(
      handlerFunc: (context, Map<String, dynamic> parameters) =>
          CustomStyleScreen());

  // =================================Cart=========================================
  static Handler _cartHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => CartScreen(),
  );

  // =================================Order=========================================
  static Handler _orderHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => OrderScreen(),
  );

  static Handler _orderDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        OrderDetailScreen(
      orderID: parameters['orderID'][0],
    ),
  );

  static Handler _orderConfirmationHandler = Handler(
  handlerFunc: (context, Map<String, dynamic> parameters) {
    print("Raw Parameters Received: $parameters");

    // Extract parameters from the map
    String comeFrom = parameters['comeFrom'][0];
    bool isWiring = parameters['isWiring'] != null && parameters['isWiring'][0] == 'true';
    bool isPiping = parameters['isPiping'] != null && parameters['isPiping'][0] == 'true';
    bool isGardening = parameters['isGardening'] != null && parameters['isGardening'][0] == 'true';
    bool isRunner = parameters['isRunner'] != null && parameters['isRunner'][0] == 'true';

    // Decode the detailData parameter
    Map<String, dynamic> detailData = {};

    if (parameters['detailData'] != null) {
      try {
        String encodedData = parameters['detailData'].first;
        detailData = jsonDecode(Uri.decodeComponent(encodedData)) as Map<String, dynamic>;

            print("Parameters Received: $parameters");
            print("Decoded comeFrom: $comeFrom");
            print("Decoded isWiring: $isWiring");
            print("Decoded isPiping: $isPiping");
            print("Decoded isGardening: $isGardening");
            print("Decoded isRunner: $isRunner");
            print("Decoded detailData: $detailData");
      } catch (e) {
        print("Error decoding detailData: $e");
      }
    }

    return OrderConfirmationScreen(
      comeFrom: comeFrom,
      isWiring: isWiring,
      isPiping: isPiping,
      isGardening: isGardening,
      isRunner: isRunner,
      detailData: detailData,
    );
  },
);


  static Handler _orderAddressHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        OrderAddressScreen(),
  );

  static Handler _orderDeliveryHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        OrderDeliveryListScreen(
      orderID: parameters['orderID'][0],
    ),
  );

  static Handler _orderReceiptHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        OrderReceiptScreen(
      orderID: parameters['orderID'][0],
    ),
  );

  // =================================Payment=========================================
  static Handler _paymentHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => PaymentScreen(
      paymentType: parameters['paymentType'][0],
      orderID: parameters['orderID'][0],
    ),
  );

  // =================================Delivery=========================================
  static Handler _deliveryHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => DeliveryScreen(),
  );

  static Handler _deliveryDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        DeliveryDetailScreen(
      deliveryId: parameters['deliveryID'][0],
    ),
  );

  static Handler _deliveryReceiptHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        DeliveryReceiptScreen(
      deliveryID: parameters['deliveryID'][0],
    ),
  );

  // =================================Bidding=========================================
  // static Handler _biddingHandler = Handler(
  //   handlerFunc: (context, Map<String, dynamic> parameters) => BiddingScreen(),
  // );

  // static Handler _biddingDetailHandler = Handler(
  //   handlerFunc: (context, Map<String, dynamic> parameters) =>
  //       BiddingDetailScreen(
  //     biddingID: parameters['biddingID'][0],
  //   ),
  // );

  // static Handler _biddingRefundHandler = Handler(
  //     handlerFunc: (context, Map<String, dynamic> parameters) =>
  //         BiddingRefundScreen());

  // =================================Vendor=========================================
  static Handler _vendorHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => VendorScreen(),
  );

  static Handler _vendorDetailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => VendorDetailScreen(
      vendorID: parameters['vendorID'][0],
      isSearch: parameters['isSearch'][0],
      isCart: parameters['isCart'][0],
    ),
  );

  static Handler _vendorSearchHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        VendorSearchScreen(),
  );

  static Handler _vendorSearchResultHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        VendorSearchResultScreen(
            searchKeyword: parameters['searchKeyword'][0]),
  );

  // =================================Account=========================================
  static Handler _accountHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => AccountScreen(),
  );

  static Handler _profileHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        UserProfileScreen(),
  );

  static Handler _settingsHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => SettingScreen(),
  );

  static Handler _addressHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => AddressScreen(),
  );

  static Handler _addressDetailHanlder = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        AddressDetailScreen(
      addressID: parameters['addressID'][0],
    ),
  );

  static Handler _addAddressHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        AddAddressScreen(),
  );

  // static Handler _changePasswordHandler = Handler(
  //   handlerFunc: (context, Map<String, dynamic> parameters) =>
  //       //ChangesPasswordScreen(),
  // );

  static Handler _changeEmailHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        ChangesEmailScreen(),
  );

  static Handler _helpHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => HelpScreen(),
  );

  static Handler _faqHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) => FAQsScreen(),
  );

// =================================image=========================================
  static Handler _imageEnlargeHandler = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) =>
        ImageEnlargeWidget(
            tag: parameters['tag'][0], url: parameters['url'][0]),
  );

//*******Route Define*********
  static void setupRoute() {
    // router.define(Routes.DASHBOARD,
    //     handler: _dashboardHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.SPLASH_SCREEN,
        handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.LOGIN_SCREEN,
        handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DASHBOARD,
        handler: _dashboardHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.REGISTER_SCREEN,
        handler: _registerHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.HOME_SCREEN,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PLANT_SCREEN,
        handler: _plantHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PLANT_DETAIL_SCREEN,
        handler: _plantDetailHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PLANT_SEARCH_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _plantSearchHandler);
    router.define(Routes.PLANT_SEARCH_RESULT_SCREEN,
        transitionType: TransitionType.fadeIn,
        handler: _plantSearchResultHandler);
    router.define(Routes.PRODUCT_SCREEN,
        handler: _productHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PRODUCT_DETAIL_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _productDetailHandler);
    router.define(Routes.WIRING_DETAIL_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _wiringDetailHandler);
    router.define(Routes.PIPING_DETAIL_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _pipingDetailHandler);
    router.define(Routes.GARDENING_DETAIL_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _gardeningDetailHandler);
    router.define(Routes.RUNNER_DETAIL_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _runnerDetailHandler);
    router.define(Routes.PRODUCT_SEARCH_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _productSearchHandler);
    router.define(Routes.PRODUCT_SEARCH_RESULT_SCREEN,
        handler: _productSearchResultHandler,
        transitionType: TransitionType.fadeIn);
    router.define(Routes.CUSTOMIZATION_SCREEN,
        handler: _customizationHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.CUSTOMIZATION_SHOW_SCREEN,
        handler: _customizationShowHandler,
        transitionType: TransitionType.fadeIn);
    router.define(Routes.CUSTOMIZATION_CONFIRM_SCREEN,
        handler: _customizationConfirmHandler,
        transitionType: TransitionType.fadeIn);
    router.define(Routes.CUSTOMIZATION_STYLE_SCREEN,
        handler: _customizationStyleHandler,
        transitionType: TransitionType.fadeIn);
    router.define(Routes.CART_SCREEN,
        transitionType: TransitionType.fadeIn, handler: _cartHandler);
    router.define(Routes.ORDER_SCREEN,
        handler: _orderHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ORDER_DETAIL_SCREEN,
        handler: _orderDetailHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ORDER_CONFIRMATION_SCREEN,
        handler: _orderConfirmationHandler,
        transitionType: TransitionType.fadeIn);
    router.define(Routes.ORDER_ADDRESS_SCREEN,
        handler: _orderAddressHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ORDER_DELIVERY_SCREEN,
        handler: _orderDeliveryHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ORDER_RECEIPT_SCREEN,
        handler: _orderReceiptHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PAYMENT_SCREEN,
        handler: _paymentHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ADDRESS_SCREEN,
        handler: _addressHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ADDRESS_DETAIL_SCREEN,
        handler: _addressDetailHanlder, transitionType: TransitionType.fadeIn);
    router.define(Routes.ADD_ADDRESS_SCREEN,
        handler: _addAddressHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DELIVERY_SCREEN,
        handler: _deliveryHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DELIVERY_DETAIL_SCREEN,
        handler: _deliveryDetailHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.DELIVERY_RECEIPT_SCREEN,
        handler: _deliveryReceiptHandler,
        transitionType: TransitionType.fadeIn);
    // router.define(Routes.BIDDING_SCREEN,
    //     handler: _biddingHandler, transitionType: TransitionType.fadeIn);
    // router.define(Routes.BIDDING_DETAIL_SCREEN,
    //      handler: _biddingDetailHandler, transitionType: TransitionType.fadeIn);
    // router.define(Routes.BIDDING_REFUND_SCREEN,
    //     handler: _biddingRefundHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.VENDOR_SCREEN,
        handler: _vendorHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.VENDOR_DETAIL_SCREEN,
        handler: _vendorDetailHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.VENDOR_SEARCH_SCREEN,
        handler: _vendorSearchHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.VENDOR_SEARCH_RESULT_SCREEN,
        handler: _vendorSearchResultHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ACCOUNT_SCREEN,
        handler: _accountHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.PROFILE_SCREEN,
        handler: _profileHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.SETTINGS_SCREEN,
        handler: _settingsHandler, transitionType: TransitionType.fadeIn);
    // router.define(Routes.CHANGE_PASSWORD_SCREEN,
    //     handler: _changePasswordHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.CHANGE_EMAIL,
        handler: _changeEmailHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.HELP_SCREEN,
        handler: _helpHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.FAQS_SCREEN,
        handler: _faqHandler, transitionType: TransitionType.fadeIn);
    // Selected Dashboard Screen
    router.define(Routes.DASHBOARD_SCREEN,
        handler: _dashScreenBoardHandler,
        transitionType: TransitionType.fadeIn);
    // Image widget
    router.define(Routes.IMAGE_ENLARGE_SCREEN,
        handler: _imageEnlargeHandler, transitionType: TransitionType.fadeIn);
  }
}
