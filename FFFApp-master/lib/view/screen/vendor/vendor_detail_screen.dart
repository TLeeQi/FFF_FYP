import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:FFF/data/model/vendor_model.dart';
import 'package:FFF/providers/vendor_provider.dart';
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/util/custom_text_style.dart';
import 'package:FFF/util/dimensions.dart';
// import 'package:FFF/util/routes.dart';
// import 'package:FFF/view/base/custom_button.dart';
import 'package:FFF/view/base/custom_space.dart';
import 'package:FFF/view/base/image_enlarge_widget.dart';
import 'package:FFF/view/base/page_loading.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class VendorDetailScreen extends StatefulWidget {
  final String vendorID;
  final String isCart;
  final String isSearch;
  const VendorDetailScreen({
    required this.vendorID,
    required this.isCart,
    required this.isSearch,
    super.key,
  });

  @override
  State<VendorDetailScreen> createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  late var vendor_prov = Provider.of<VendorProvider>(context, listen: false);
  late Vendor vendor = Vendor();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return getVendorInformation();
    });
  }

  getVendorInformation() {
    if (widget.isSearch == "true") {
      vendor = vendor_prov.vendorListSearch
          .firstWhere((element) => element.id.toString() == widget.vendorID);
    } else {
      vendor = vendor_prov.vendorList
          .firstWhere((element) => element.id.toString() == widget.vendorID);
    }

    setState(() {
      isLoading = false;
    });
  }

  // Function to make a phone call
  Future<void> _callVendor(String phone) async {
    Clipboard.setData(ClipboardData(text: phone));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phone number copied to clipboard')),
    );

    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Could not launch $phoneUri');
    }
  }

  // Function to send an email
  Future<void> _emailVendor(String email) async {
      Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email copied to clipboard')),
    );

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Inquiry%20from%20FFF%20App&body=Hello,%20I%20would%20like%20to%20inquire%20about%20your%20services.',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch $emailUri');
    }
  }

  // Function to show the vendor's address on Google Maps
  Future<void> _showAddressOnMap(String address) async {

    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Address copied to clipboard')),
    );

    final Uri mapUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {'q': address},
    );
    print('mapUri: $mapUri');
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);
    } else {
      print('Could not launch $mapUri');
    }
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
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          title: Text(
            "Vendor Detail",
            style: CustomTextStyles(context).titleStyle.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
          backgroundColor: ColorResources.COLOR_PRIMARY,
          actions: [
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            height: 60,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _callVendor(vendor.phone ?? ''),
                child: Container(
                  color: ColorResources.COLOR_PRIMARY,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, color: Colors.white),
                      Text(
                        'Call Vendor',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _emailVendor(vendor.email ?? ''),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: ColorResources.COLOR_PRIMARY),
                      Text(
                        'Email Vendor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ColorResources.COLOR_PRIMARY,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _showAddressOnMap(vendor.address ?? ''),
                child: Container(
                  color: ColorResources.COLOR_PRIMARY,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.white),
                      Text(
                        'Address',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
        body: SafeArea(
          child: Center(
            child: isLoading
                ? LoadingThreeCircle()
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: ColorResources.COLOR_WHITE,
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return ImageEnlargeWidget(
                                    tag: "vendor_${vendor.id}",
                                    url: "${vendor.imageURL!}",
                                  );
                                }));
                              },
                              child: Hero(
                                tag: "vendor_${vendor.id}",
                                child: CachedNetworkImage(
                                  height: 300,
                                  fit: BoxFit.fitHeight,
                                  imageUrl: "${vendor.imageURL!}",
                                  filterQuality: FilterQuality.high,
                                  memCacheHeight: 200,
                                  memCacheWidth: 200,
                                  placeholder: (context, url) => Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: ColorResources.COLOR_GRAY,
                                    )),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorResources.COLOR_WHITE,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${vendor.name}",
                                    style: CustomTextStyles(context)
                                        .titleStyle
                                        .copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE)),
                                VerticalSpacing(
                                  height: 10,
                                ),
                                Text("${vendor.address}",
                                    style: CustomTextStyles(context)
                                        .titleStyle
                                        .copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_LARGE,
                                            color:
                                                ColorResources.COLOR_PRIMARY)),
                              ],
                            ),
                          ),
                          VerticalSpacing(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorResources.COLOR_WHITE,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Rating:",
                                    style:
                                        CustomTextStyles(context).titleStyle),
                                HorizontalSpacing(
                                  width: 3,
                                ),
                                Text("${vendor.rating}",
                                    style: CustomTextStyles(context)
                                        .subTitleStyle),
                                Expanded(child: Container()),
                                HorizontalSpacing(
                                  width: 3,
                                ),
                                ..._buildStars(double.parse(vendor.rating.toString())), // Build stars based on rating
                                SizedBox(width: 4),
                              ],
                            ),
                          ),
                          VerticalSpacing(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorResources.COLOR_WHITE,
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Description",
                                    style:
                                        CustomTextStyles(context).titleStyle),
                                VerticalSpacing(
                                  height: 10,
                                ),
                                Text("${vendor.description}",
                                    style: CustomTextStyles(context)
                                        .subTitleStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
