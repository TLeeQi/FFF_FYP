// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nurserygardenapp/providers/cart_provider.dart';
import 'package:nurserygardenapp/providers/address_provider.dart';
import 'package:nurserygardenapp/providers/order_provider.dart';
import 'package:nurserygardenapp/providers/plant_provider.dart';
import 'package:nurserygardenapp/providers/product_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/circular_indicator.dart';
import 'package:nurserygardenapp/view/base/page_loading.dart';
import 'package:nurserygardenapp/view/screen/payment/payment_helper/payment_type.dart';
import 'package:provider/provider.dart';
// import 'dart:io';

class OrderConfirmationScreen extends StatefulWidget {
  final String comeFrom;
  final bool isWiring;
  final bool isPiping;
  final bool isGardening;
  final bool isRunner;
  final Map<String, dynamic> detailData;

  OrderConfirmationScreen({
    Key? key,
    this.comeFrom = "",
    this.isWiring = false,
    this.isPiping = false,
    this.isGardening = false,
    this.isRunner = false,
    required this.detailData,
  }) : super(key: key) {
    print("OrderConfirmationScreen initialized:");
    print("isWiring: $isWiring");
    print("isPiping: $isPiping");
    print("isGardening: $isGardening");
    print("isRunner: $isRunner");
    print("detailData: $detailData");
  }

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final String cartMode = "cart";
  final String plantMode = "plant";
  final String productMode = "product";

  late CartProvider cart_prov =
      Provider.of<CartProvider>(context, listen: false);
  late OrderProvider order_prov =
      Provider.of<OrderProvider>(context, listen: false);
  late AddressProvider address_prov =
      Provider.of<AddressProvider>(context, listen: false);
  double totalAmount = 50;

  final String emptyAddress_msg =
      "Please add your address prior make the order.";

  final String error_msg = "Some error occur, please try again later.";

  String address = "";

  var params = {};

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return _getInitalData();
    });
  }

  _getInitalData() async {
    double total = 50;
    bool result = await address_prov.getAddressList(context, params);

    setState(() {
      totalAmount = total;
      if (result) {
        if (address_prov.addressList.length > 0) {
          address = address_prov.addressList[0].address ?? '';
        } else {
          address = emptyAddress_msg;
        }
      } else {
        address = error_msg;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("isWiring: ${widget.isWiring}");
    print("detailData: ${widget.detailData}");

    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorResources.COLOR_PRIMARY,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                // if(widget.isWiring){
                //   Navigator.pushNamedAndRemoveUntil(context,
                //     Routes.getWiringDetailRoute(widget.detailData['prod_id'], "false", "false"), (route) => false);
                // }else if(widget.isPiping){
                //   Navigator.pushNamedAndRemoveUntil(context,
                //     Routes.getPipingDetailRoute(widget.detailData['id'], "false", "false"), (route) => false);
                // }else if(widget.isGardening){
                //   Navigator.pushNamedAndRemoveUntil(context,
                //     Routes.getGardeningDetailRoute(widget.detailData['id'], "false", "false"), (route) => false);
                // }else if(widget.isRunner){
                //   Navigator.pushNamedAndRemoveUntil(context,
                //     Routes.getRunnerDetailRoute(widget.detailData['id'], "false", "false"), (route) => false);
                // }
              },
            ),
            title: Text(
              "Booking Details",
              style: CustomTextStyles(context).subTitleStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white),
            )),
        bottomNavigationBar: BottomAppBar(
            height: 60,
            padding: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(0, 2),
                      blurRadius: 10.0),
                ],
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_WHITE,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Total RM: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: ColorResources.COLOR_BLACK),
                                ),
                                Text(totalAmount.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: ColorResources.COLOR_PRIMARY))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Consumer2<OrderProvider, CartProvider>(builder:
                          (context, orderProvider, cartProvider, child) {
                        return GestureDetector(
                          onTap: () async {
                            if (address == emptyAddress_msg) {
                              EasyLoading.showError('Please add your address',
                                  dismissOnTap: true,
                                  duration: Duration(milliseconds: 500));
                              return;
                            }
                            if (address == error_msg) {
                              EasyLoading.showError(
                                  'Some error occur, please try again later',
                                  dismissOnTap: true,
                                  duration: Duration(milliseconds: 500));
                              return;
                            }
                            if (orderProvider.isLoading) return;
                            if (widget.comeFrom == cartMode) {
                              if (orderProvider.isLoading) return;
                              await orderProvider
                                  .addOrder(
                                      cart_prov.addedCartList, address, context)
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pushReplacementNamed(
                                      context,
                                      Routes.getPaymentRoute(
                                          (PaymentType.card).toString(),
                                          orderProvider.orderIdCreated));
                                }
                              });
                            }
                            if (widget.comeFrom == plantMode) {
                              if (cartProvider.isLoading ||
                                  orderProvider.isLoading) return;

                              await cartProvider
                                  .addToCart(
                                      context, cartProvider.addedCartList.first,
                                      ismsg: false, isCart: false)
                                  .then((value) async {
                                if (value == true) {
                                  await orderProvider
                                      .addOrder(cartProvider.returnAddCart,
                                          address, context)
                                      .then((value) {
                                    if (value == true) {
                                      Navigator.pushReplacementNamed(
                                          context,
                                          Routes.getPaymentRoute(
                                              (PaymentType.card).toString(),
                                              orderProvider.orderIdCreated));
                                    }
                                  });
                                }
                              });
                            }
                            if (widget.comeFrom == productMode) {
                              if(widget.isWiring){
                                  // await orderProvider
                                  //   .storeWiringDetail(widget.detailData, context)
                                  //   .then((value) async {
                                  //     if (value == true) {
                                        Navigator.pushReplacementNamed(
                                            context,
                                            Routes.getPaymentRoute(
                                                (PaymentType.card).toString(),
                                                orderProvider.orderIdCreated));
                                    //   }
                                    // });
                                  }
                                  else if(widget.isPiping){
                                    // await orderProvider
                                    // .storePipingDetail(widget.detailData, context)
                                    // .then((value) async {
                                    //   if (value == true) {
                                        Navigator.pushReplacementNamed(
                                            context,
                                            Routes.getPaymentRoute(
                                                (PaymentType.card).toString(),
                                                orderProvider.orderIdCreated));
                                    //   }
                                    // });
                                  }
                                  else if(widget.isGardening){
                                    // await orderProvider
                                    // .storeGardeningDetail(widget.detailData, context)
                                    // .then((value) async {
                                    //   if (value == true) {
                                        Navigator.pushReplacementNamed(
                                            context,
                                            Routes.getPaymentRoute(
                                                (PaymentType.card).toString(),
                                                orderProvider.orderIdCreated));
                                    //   }
                                    // });
                                  }
                                  else if(widget.isRunner){
                                    // await orderProvider
                                    // .storeRunnerDetail(widget.detailData, context)
                                    // .then((value) async {
                                      // if (value == true) {
                                        Navigator.pushReplacementNamed(
                                            context,
                                            Routes.getPaymentRoute(
                                                (PaymentType.card).toString(),
                                                orderProvider.orderIdCreated));
                                    //   }
                                    // });
                                  }else {
                                    await cartProvider
                                        .addToCart(
                                          context, 
                                          cartProvider.addedCartList.first,
                                          ismsg: false, 
                                          isCart: false,
                                        )
                                        .then((value) async {
                                          if (value == true) {
                                            await orderProvider
                                                .addOrder(
                                                  cartProvider.returnAddCart,
                                                  address, 
                                                  context,
                                                )
                                                .then((value) {
                                                  if (value == true) {
                                                    Navigator.pushReplacementNamed(
                                                      context,
                                                      Routes.getPaymentRoute(
                                                        (PaymentType.card).toString(),
                                                        orderProvider.orderIdCreated,
                                                      ),
                                                    );
                                                  }
                                                });
                                          }
                                        });
                                  }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: address == emptyAddress_msg ||
                                      address == error_msg
                                  ? ColorResources.COLOR_PRIMARY
                                      .withOpacity(0.7)
                                  : ColorResources.COLOR_PRIMARY,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                orderProvider.isLoading
                                    ? CircularProgress()
                                    : Text(
                                        'Place Order',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ]),
            )),
        body: Consumer4<CartProvider, AddressProvider, PlantProvider,
                ProductProvider>(
            builder: (context, cartProvider, addressProvider, plantProvider,
                productProvider, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: addressProvider.isLoading
                ? LoadingThreeCircle()
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                    context, Routes.getOrderAddressRoute(),
                                    arguments: {'orderID': "0", "address": ""})
                                .then((value) {
                              if (value == null) return;
                              setState(() {
                                address = value as String;
                              });
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery Address",
                                  style: CustomTextStyles(context)
                                      .titleStyle
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  address,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: address == emptyAddress_msg ||
                                            address == error_msg
                                        ? ColorResources.APPBAR_HEADER_COLOR
                                            .withOpacity(0.9)
                                        : ColorResources.COLOR_BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Divider(
                            color: ColorResources.COLOR_GREY.withOpacity(0.1),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                        Container(
                          child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (widget.isWiring) _buildWiringDetails(widget.detailData),
                                if (widget.isPiping) _buildPipingDetails(widget.detailData),
                                if (widget.isGardening) _buildGardeningDetails(widget.detailData),
                                if (widget.isRunner) _buildRunnerDetails(widget.detailData),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order Total",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "RM" + "${totalAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorResources.COLOR_PRIMARY),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.monetization_on),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      "Payment Options",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Debit/Credit card",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorResources.COLOR_PRIMARY),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        }));
  }
  
  Widget _buildWiringDetails(Map<String, dynamic> data) {
    print("Building OrderConfirmationScreen with detailData Wiring: $data");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Wiring Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildDetailRow("Service Type", data['type']),
          _buildDetailRow("Fix Items", (data['fixitem'] as List?)?.join(', ') ?? "N/A"),
          _buildDetailRow("Has Parts", data['ishavepart'] ? "Yes" : "No"),
          _buildDetailRow("Property Type", data['types_property']),
          _buildDetailRow("Appointment Date", data['app_date']),
          _buildDetailRow("Preferred Time", data['preferred_time']),
          _buildDetailRow("Additional Details", data['details']),
          _buildDetailRow("Budget", data['budget']),
          _buildDetailRow("Address", data['address']),
          SizedBox(height: 10),
          Text(
            "Uploaded Photos",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildPhotoGallery(data['photo']),
        ],
      ),
    );
  }

  Widget _buildPipingDetails(Map<String, dynamic> data) {
    print("Building OrderConfirmationScreen with detailData Piping: $data");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Piping Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildDetailRow("Service Type", data['type']),
          _buildDetailRow("Fix Items", (data['fixitem'] as List?)?.join(', ') ?? "N/A"),
          _buildDetailRow("Problems", (data['problem'] as List?)?.join(', ') ?? "N/A"),
          _buildDetailRow("Property Type", data['types_property']),
          _buildDetailRow("Appointment Date", data['app_date']),
          _buildDetailRow("Preferred Time", data['preferred_time']),
          _buildDetailRow("Additional Details", data['details']),
          _buildDetailRow("Budget", data['budget']),
          _buildDetailRow("Address", data['address']),
          SizedBox(height: 10),
          Text(
            "Uploaded Photos",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildPhotoGallery(data['photo']),
        ],
      ),
    );
  }

  Widget _buildGardeningDetails(Map<String, dynamic> data) {
    print("Building OrderConfirmationScreen with detailData Gardening: $data");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Gardening Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildDetailRow("Service Type", data['type']),
          _buildDetailRow("Area", data['area']),
          _buildDetailRow("Property Type", data['types_property']),
          _buildDetailRow("Appointment Date", data['app_date']),
          _buildDetailRow("Preferred Time", data['preferred_time']),
          _buildDetailRow("Additional Details", data['details']),
          _buildDetailRow("Budget", data['budget']),
          _buildDetailRow("Address", data['address']),
          SizedBox(height: 10),
          Text(
            "Uploaded Photos",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildPhotoGallery(data['photo']),
        ],
      ),
    );
  }

  Widget _buildRunnerDetails(Map<String, dynamic> data) {
    print("Building OrderConfirmationScreen with detailData Piping: $data");
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Piping Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildDetailRow("Service Type", data['type']),
          _buildDetailRow("Area", data['area']),
          _buildDetailRow("Appointment Date", data['app_date']),
          _buildDetailRow("Preferred Time", data['preferred_time']),
          _buildDetailRow("Additional Details", data['details']),
          _buildDetailRow("Budget", data['budget']),
          _buildDetailRow("Address", data['address']),
          SizedBox(height: 10),
          Text(
            "Uploaded Photos",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildPhotoGallery(data['photo']),
        ],
      ),
    );
  }
}

Widget _buildDetailRow(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value ?? "N/A"),
        ),
      ],
    ),
  );
}

Widget _buildPhotoGallery(dynamic photoPaths) {
  if (photoPaths == null || photoPaths is! String || photoPaths.isEmpty) {
    return Text("No photos uploaded.");
  }

  // Split the comma-separated string into a list of filenames
  List<String> photoList = photoPaths.split(',');

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: photoList.map((filename) {
      // Assuming the images are stored in a specific directory
      //ngrok
      String filePath = 'https://d706-2405-3800-850-d9bc-71ca-7038-5869-8337.ngrok-free.app/service_image/$filename'; // Update this path as needed
      print('filePath: $filePath');
      
      return Image.network(
        filePath,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.broken_image, size: 100);
        },
      );
    }).toList(),
  );
}
