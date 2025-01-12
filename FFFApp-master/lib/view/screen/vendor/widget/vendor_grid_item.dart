// import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nurserygardenapp/data/model/vendor_model.dart';
// import 'package:nurserygardenapp/providers/vendor_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/view/base/custom_space.dart';
// import 'package:provider/provider.dart';

class VendorGridItem extends StatefulWidget {
  const VendorGridItem({
    super.key,
    required this.vendor,
    required this.onTap,
  });

  final Vendor vendor;
  final void Function() onTap;

  @override
  State<VendorGridItem> createState() => _VendorGridItemState();
}

class _VendorGridItemState extends State<VendorGridItem> {

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  List<Widget> _buildStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor(); // Full stars
    bool hasHalfStar = (rating - fullStars) >= 0.25; // Check for half star

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: Colors.amber, size: 16));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(Icon(Icons.star_half, color: Colors.amber, size: 16));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.amber, size: 16));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    // print("vendor.image: ${widget.vendor.image}");

    // String imageUrl = widget.vendor.image != null && widget.vendor.image!.isNotEmpty
    //     ? 'assets/vendor_image/${widget.vendor.image}'
    //     : 'assets/vendor_image/no_vendor.png'; // Use local asset if no image URL

    // print("imageUrl: $imageUrl");
    Size size = MediaQuery.of(context).size;
    print('Vendor: ${widget.vendor}');
    print('Vendor ImageURL: ${widget.vendor.imageURL}');
    print('Vendor Image: ${widget.vendor.image}');
    print('Vendor Name: ${widget.vendor.name}');
    print('Vendor Email: ${widget.vendor.email}');
    print('Vendor Phone: ${widget.vendor.phone}');
    print('Vendor Rating: ${widget.vendor.rating}');

    return InkWell(
      onTap: widget.onTap,

      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: size.width * 0.9,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorResources.COLOR_WHITE,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 10.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                //child: Text('image'),
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.high,
                  imageUrl: "${widget.vendor.imageURL!}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              VerticalSpacing(),
              Text(
                widget.vendor.name!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                    ),
              ),
              Text(
                "Email: ${widget.vendor.email}",
                style: CustomTextStyles(context).subTitleStyle.copyWith(
                      color: ColorResources.COLOR_PRIMARY,
                      fontSize: 12,
                    ),
              ),
              Text(
                "Phone: ${widget.vendor.phone}",
                style: CustomTextStyles(context).subTitleStyle.copyWith(
                      color: ColorResources.COLOR_PRIMARY,
                      fontSize: 12,
                    ),
              ),
              // Text(
              //   "Rating: ${vendor.rating?.toStringAsFixed(1) ?? 'N/A'}",
              //   //"rate",
              //   style: CustomTextStyles(context).subTitleStyle.copyWith(
              //         color: ColorResources.COLOR_PRIMARY,
              //         fontSize: 12,
              //       ),
              // ),
              Row(
                children: [
                  ..._buildStars(widget.vendor.rating ?? 0.0), // Build stars based on rating
                  SizedBox(width: 4),
                  Text(
                    "${widget.vendor.rating?.toStringAsFixed(1) ?? 'N/A'}",
                    style: CustomTextStyles(context).subTitleStyle.copyWith(
                          color: ColorResources.COLOR_PRIMARY,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
