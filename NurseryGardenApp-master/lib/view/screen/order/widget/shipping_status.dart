import 'package:flutter/material.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/screen/order/widget/shipping_icon.dart';

class ShippingStatus extends StatefulWidget {
  final String orderID;
  final String status;

  ShippingStatus({
    super.key,
    required this.status,
    required this.orderID,
  });

  @override
  State<ShippingStatus> createState() => _ShippingStatusState();
}

class _ShippingStatusState extends State<ShippingStatus> {
  @override
  void initState() {
    super.initState();
    print(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    Widget payWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
        color: ColorResources.COLOR_WHITE,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ShippingIcon(
            icon: Icons.paid_outlined,
            color: ColorResources.COLOR_BLACK.withOpacity(0.8),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Payment Pending....",
                  style: CustomTextStyles(context)
                      .titleStyle
                      .copyWith(fontSize: 16)),
              SizedBox(height: 3),
              Text("Please pay to confirm your booking",
                  style: CustomTextStyles(context)
                      .subTitleStyle
                      .copyWith(fontSize: 14))
            ],
          )
        ],
      ),
    );

    Widget cancelWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      decoration: BoxDecoration(
        color: ColorResources.COLOR_WHITE,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ShippingIcon(
            icon: Icons.close_sharp,
            color: Colors.red.withOpacity(0.8),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Booking Cancelled",
                  style: CustomTextStyles(context)
                      .titleStyle
                      .copyWith(fontSize: 16)),
              SizedBox(height: 3),
              Text("Your booking has been cancelled",
                  style: CustomTextStyles(context)
                      .subTitleStyle
                      .copyWith(fontSize: 14))
            ],
          )
        ],
      ),
    );

    Widget shipWidget = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.getDeliveryDetailRoute("0"),
            arguments: {
              "orderID": widget.orderID,
            });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(
          color: ColorResources.COLOR_WHITE,
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShippingIcon(
              icon: Icons.inventory_rounded,
              color: ColorResources.COLOR_PRIMARY,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Booking Placed",
                    style: CustomTextStyles(context)
                        .titleStyle
                        .copyWith(fontSize: 16)),
                SizedBox(height: 3),
                Text("Admin is searching your service provider",
                    style: CustomTextStyles(context)
                        .subTitleStyle
                        .copyWith(fontSize: 14))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: ColorResources.COLOR_PRIMARY,
            )
          ],
        ),
      ),
    );

    Widget receiveWidget = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.getDeliveryDetailRoute("0"),
            arguments: {
              "orderID": widget.orderID,
            });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(
          color: ColorResources.COLOR_WHITE,
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShippingIcon(
              icon: Icons.local_shipping_outlined,
              color: ColorResources.COLOR_PRIMARY,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Booking Confirmed",
                    style: CustomTextStyles(context)
                        .titleStyle
                        .copyWith(fontSize: 16)),
                SizedBox(height: 3),
                Text("Service provider is on the way",
                    style: CustomTextStyles(context)
                        .subTitleStyle
                        .copyWith(fontSize: 14))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: ColorResources.COLOR_PRIMARY,
            )
          ],
        ),
      ),
    );

    Widget completeWidget = GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            Routes.getOrderDeliveryRoute(
              widget.orderID,
            ));
        // Navigator.pushNamed(context, Routes.getDeliveryDetailRoute("0"),
        //     arguments: {
        //       "orderID": widget.orderID,
        //     });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(
          color: ColorResources.COLOR_WHITE,
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShippingIcon(
              icon: Icons.task_alt_outlined,
              color: ColorResources.COLOR_PRIMARY,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Booking Completed",
                    style: CustomTextStyles(context)
                        .titleStyle
                        .copyWith(fontSize: 16)),
                SizedBox(height: 3),
                Text("Your requested service has been completed",
                    style: CustomTextStyles(context)
                        .subTitleStyle
                        .copyWith(fontSize: 14))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: ColorResources.COLOR_PRIMARY,
            )
          ],
        ),
      ),
    );

    Widget partialWidget = GestureDetector(
      onTap: () {
        Navigator.pushNamed(
            context,
            Routes.getOrderDeliveryRoute(
              widget.orderID,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(
          color: ColorResources.COLOR_WHITE,
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShippingIcon(
              icon: Icons.list_alt_outlined,
              color: ColorResources.COLOR_PRIMARY,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Booking Separate",
                    style: CustomTextStyles(context)
                        .titleStyle
                        .copyWith(fontSize: 16)),
                SizedBox(height: 3),
                Text("Your booking has been separate to prepare",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: CustomTextStyles(context)
                        .subTitleStyle
                        .copyWith(fontSize: 14))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: ColorResources.COLOR_PRIMARY,
            )
          ],
        ),
      ),
    );

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.status == "pay") payWidget,
          if (widget.status == "prepare") shipWidget,
          if (widget.status == "confirm") receiveWidget,
          if (widget.status == "partial") partialWidget,
          if (widget.status == "completed") completeWidget,
          if (widget.status == "cancel") cancelWidget,
        ],
      ),
    );
  }
}
