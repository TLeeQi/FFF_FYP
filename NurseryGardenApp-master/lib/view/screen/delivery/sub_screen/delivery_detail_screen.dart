import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nurserygardenapp/data/model/delivery_model.dart';
import 'package:nurserygardenapp/data/model/order_model.dart';
import 'package:nurserygardenapp/providers/delivery_provider.dart';
import 'package:nurserygardenapp/providers/order_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/dimensions.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/custom_appbar.dart';
import 'package:nurserygardenapp/view/base/image_enlarge_widget.dart';
import 'package:nurserygardenapp/view/base/page_loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final String deliveryId;
  const DeliveryDetailScreen({
    super.key,
    required this.deliveryId,
  });

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  late OrderProvider _orderProv =
      Provider.of<OrderProvider>(context, listen: false);
  late DeliveryProvider _deliveryProvider =
      Provider.of<DeliveryProvider>(context, listen: false);

  Delivery delivery = Delivery();
  int _currentStep = 0;

  void tapped(int step) {
    setState(() => _currentStep = step);
  }

  void continued() {
    FocusScope.of(context).unfocus();
    return null;
    // _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  void cancel() {
    FocusScope.of(context).unfocus();
    return null;
    // _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();      
    });
  }

  void _loadData() async {
    // Get from the route args
    if (widget.deliveryId == "0") {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      Order _order = _orderProv.orderList.firstWhere(
          (element) => element.id.toString() == args['orderID'].toString());
      bool result = await _deliveryProvider
          .getDeliveryList(context, {'order_id': _order.id.toString()});
      if (result) {
        delivery = _deliveryProvider.deliveryList.isEmpty
            ? Delivery(
                id: 0,
                orderId: _order.id,
                orderAddress: _order.address,
                orderDate: _order.createdAt,
                expectedDate: DateTime.now(),
                status: "",
                trackingNumber: "",
                imageURL: "",
                createdAt: _order.createdAt,
                updatedAt: _order.updatedAt,
              )
            : _deliveryProvider.deliveryList.first;
      }
    } else {
      bool result = await _deliveryProvider
          .getDeliveryDetail(context, {'id': widget.deliveryId});
      if (result) {
        delivery = _deliveryProvider.deliveryDetail;
      }
    }

    print('delivery.status: ${delivery.status}');

    if (delivery.status == "confirm") {
      _currentStep = 1;
    } else if (delivery.status == "Completed") {
      _currentStep = 2;
    } else {
      _currentStep = 0;
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        isBgPrimaryColor: true,
        isCenter: false,
        isBackButtonExist: false,
        title: "Booking Status",
        context: context,
      ),
      body: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        height: size.height,
        width: size.width,
        child: Consumer2<OrderProvider, DeliveryProvider>(
            builder: (context, orderProvider, deliveryProvider, child) {
          return orderProvider.isLoading ||
                  deliveryProvider.isLoading ||
                  deliveryProvider.isLoadingDetail
              ? LoadingThreeCircle()
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_WHITE,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: double.infinity,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (delivery.status == "")
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 15, 10),
                                  child: Icon(
                                    Icons.inventory_rounded,
                                    size: 30,
                                    color: ColorResources.COLOR_PRIMARY,
                                  ),
                                ),
                              if (delivery.status == "confirm")
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 15, 10),
                                  child: Icon(
                                    Icons.local_shipping_outlined,
                                    size: 30,
                                    color: ColorResources.COLOR_PRIMARY,
                                  ),
                                ),
                              if (delivery.status == "Completed")
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 15, 10),
                                  child: Icon(
                                    Icons.task_alt_outlined,
                                    size: 30,
                                    color: ColorResources.COLOR_PRIMARY,
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (delivery.status == "")
                                    Text("Admin is searching your service provider",
                                        style: CustomTextStyles(context)
                                            .titleStyle),
                                  if (delivery.status == "confirm")
                                    Text("Service provider is on the way",
                                        style: CustomTextStyles(context)
                                            .titleStyle),
                                  if (delivery.status == "Completed")
                                    Text("Your requested service has been completed",
                                        style: CustomTextStyles(context)
                                            .titleStyle),
                                  SizedBox(height: 10),
                                  if (delivery.status == "")
                                    Row(
                                      children: [
                                        Text("Requested Date: ",
                                            style: CustomTextStyles(context)
                                                .subTitleStyle),
                                        Text(
                                            DateFormat('dd-MM-yyyy')
                                                .format(delivery.orderDate!),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle),
                                      ],
                                    ),
                                  if (delivery.status == "confirm")
                                    Row(
                                      children: [
                                        Text("Expected Date: ",
                                            style: CustomTextStyles(context)
                                                .subTitleStyle),
                                        Text(
                                            DateFormat('dd-MM-yyyy')
                                                .format(delivery.expectedDate!),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle),
                                      ],
                                    ),
                                  if (delivery.status == "Completed")
                                    Text(
                                        DateFormat('dd-MM-yyyy').format(
                                            delivery.updatedAt ??
                                                DateTime.now()),
                                        style: CustomTextStyles(context)
                                            .subTitleStyle),
                                ],
                              ),
                            ]),
                      ),
                      SizedBox(height: 20),
                      if (delivery.status != null)
                        Container(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          decoration: BoxDecoration(
                            color: ColorResources.COLOR_WHITE,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Order ID: ",
                                        style: CustomTextStyles(context)
                                            .titleStyle),
                                    SizedBox(height: 10),
                                    Text(delivery.orderId.toString(),
                                        style: CustomTextStyles(context)
                                            .subTitleStyle),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address: ",
                                        style: CustomTextStyles(context)
                                            .titleStyle),
                                    SizedBox(height: 10),
                                    Flexible(
                                      child: Text(delivery.orderAddress ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                          style: CustomTextStyles(context)
                                              .subTitleStyle),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      // Click to view delivery order item
                      if (delivery.status == "Completed" ||
                          delivery.status == "confirm")
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routes.getDeliveryReceiptRoute(
                                  delivery.id.toString()),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: ColorResources.COLOR_WHITE,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Click here to view booking detail",
                                      style:
                                          CustomTextStyles(context).titleStyle),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorResources.COLOR_PRIMARY,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                          color: ColorResources.COLOR_WHITE,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Booking Status",
                                      style:
                                          CustomTextStyles(context).titleStyle),
                                  Spacer(),
                                  if (delivery.status == "Completed" ||
                                      delivery.status == "confirm")
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: InkWell(
                                        onTap: () {
                                          Clipboard.setData(new ClipboardData(
                                              text: delivery.trackingNumber ??
                                                  ""));
                                        },
                                        child: Text(
                                          "Vendor Contact:",
                                          style: CustomTextStyles(context)
                                              .titleStyle
                                              .copyWith(
                                                  color: ColorResources
                                                      .COLOR_PRIMARY),
                                        ),
                                      ),
                                    ),
                                  if (delivery.status == "Completed" ||
                                      delivery.status == "confirm")
                                    Text(delivery.trackingNumber ?? "",
                                        style: CustomTextStyles(context)
                                            .subTitleStyle),
                                ],
                              ),
                              Stepper(
                                connectorColor:
                                    WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return ColorResources.COLOR_GREY;
                                  }
                                  return ColorResources.COLOR_PRIMARY;
                                }),
                                controlsBuilder: (context, details) {
                                  if (delivery.status == "Completed") {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // print(delivery.imageURL!);
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return ImageEnlargeWidget(
                                                tag: "delivery_${delivery.id}",
                                                url: "${delivery.imageURL!}",
                                              );
                                            }));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 10, 5, 0),
                                            child: Text(
                                              "View Proof of Completed Booking",
                                              style: CustomTextStyles(context)
                                                  .titleStyle
                                                  .copyWith(
                                                      color: ColorResources
                                                          .COLOR_PRIMARY),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                                currentStep: _currentStep,
                                steps: [
                                  Step(
                                    state: StepState.indexed,
                                    title: Text(
                                      'Booking Requested',
                                      style:
                                          CustomTextStyles(context).titleStyle,
                                    ),
                                    subtitle: Text(
                                      DateFormat('dd-MM-yyyy HH:mm').format(
                                          delivery.orderDate ?? DateTime.now()),
                                      style: CustomTextStyles(context)
                                          .subTitleStyle
                                          .copyWith(fontSize: 12),
                                    ),
                                    content: Text(
                                        'Admin is searching your service provider.',
                                        style: CustomTextStyles(context)
                                            .subTitleStyle),
                                    isActive: true,
                                  ),
                                  Step(
                                    state: StepState.indexed,
                                    title: Text(
                                      'Service Provider Found',
                                      style:
                                          CustomTextStyles(context).titleStyle,
                                    ),
                                    subtitle: delivery.status == "Completed" ||
                                            delivery.status == "confirm"
                                        ? Text(
                                            DateFormat('dd-MM-yyyy HH:mm')
                                                .format(delivery.createdAt!),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle
                                                .copyWith(fontSize: 12),
                                          )
                                        : null,
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Your booking has been confirmed and is on the way.',
                                          style: CustomTextStyles(context).subTitleStyle,
                                        ),
                                        SizedBox(height: 8), // Add some space between the lines
                                        Text(
                                          'Assigned Vendor: ${delivery.method}',
                                          style: CustomTextStyles(context)
                                              .subTitleStyle
                                              .copyWith(fontWeight: FontWeight.bold, color: ColorResources.COLOR_PRIMARY), // Customize font
                                        ),
                                      ],
                                    ),
                                    isActive: delivery.status == "Completed" ||
                                        delivery.status == "confirm",
                                  ),
                                  Step(
                                    state: StepState.complete,
                                    title: Text(
                                      'Booking Completed',
                                      style:
                                          CustomTextStyles(context).titleStyle,
                                    ),
                                    subtitle: delivery.status == "Completed"
                                        ? Text(
                                            DateFormat('dd-MM-yyyy HH:mm')
                                                .format(delivery.updatedAt!),
                                            style: CustomTextStyles(context)
                                                .subTitleStyle
                                                .copyWith(fontSize: 12))
                                        : null,
                                    content: Text(
                                        'Your requested service has been completed.',
                                        style: CustomTextStyles(context)
                                            .subTitleStyle),
                                    isActive: delivery.status == "Completed",
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
