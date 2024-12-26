import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:nurserygardenapp/data/model/cart_model.dart';
import 'package:nurserygardenapp/data/model/product_model.dart';
import 'package:nurserygardenapp/providers/cart_provider.dart';
import 'package:nurserygardenapp/providers/order_provider.dart';
import 'package:nurserygardenapp/providers/product_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/dimensions.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/custom_button.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class GardeningDetailScreen extends StatefulWidget {
  final String productID;
  final String isCart;
  final String isSearch;
  const GardeningDetailScreen({
    required this.productID,
    required this.isCart,
    required this.isSearch,
    super.key,
  });

  @override
  State<GardeningDetailScreen> createState() => _GardeningDetailScreenState();
}

class _GardeningDetailScreenState extends State<GardeningDetailScreen> {
  late var product_prov = Provider.of<ProductProvider>(context, listen: false);
  late var cart_prov = Provider.of<CartProvider>(context, listen: false);
  late Product product = Product();
  bool isLoading = true;
  int cartQuantity = 1;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form fields
  String? gardeningService;
  bool _isPricingVisible = false;
  String? area;
  String? propertyType;
  DateTime? appointmentDate;
  String? appointmentTime;
  String? additionalDetails;
  List<File> uploadedPhotos = []; // Updated for photo uploads
  String? budget;
  String? address;

  // Dummy data
  final List<String> gardeningServiceOptions = [
    'Grass Cutting',
    'Tree Trimming',
    'Flower Planting',
    'Other (Explain in Additional Details)'
  ];
  final List<String> areaOptions = [
    'Below 500 sqr ft',
    '500 - 1000 sqr ft',
    'Above 1000 sqr ft',
  ];
  final List<String> propertyTypeOptions = [
    'Landed (e.g. terrace, semi-d, bungalow)',
    'High-rise (e.g. condo, apartment)',
    'Light Commercial (e.g. office, shop, cafe)',
    'Commercial (e.g. factory, shopping centre)'
  ];
  final List<String> appointmentTimeOptions = [
    'Morning (9 AM - 11 PM)',
    'Lunch Time (11 AM - 1 PM)',
    'Early Afternoon (1 PM - 3 PM)',
    'Late Afternoon (3 PM - 5 PM)',
    'Anytime'
  ];
  final List<String> budgetOptions = [
    'RM1 - RM 79',
    'RM 80 - RM 199',
    'RM 200 - RM 499',
    'RM 500 - RM 1999',
    'RM2000 - RM4999',
    'RM5000 - RM9999',
    'RM10000 - RM19999',
    'RM20000 - RM49999',
    'RM50000 - RM99999',
    'RM100000 - RM199999',
    'RM200000 - Above'
  ];

   // Handlers
  void _selectAppointmentDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != appointmentDate) {
      setState(() {
        appointmentDate = picked;
      });
    }
  }

  void _pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        uploadedPhotos.add(File(photo.path));
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      uploadedPhotos.removeAt(index);
    });
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
  
    // Create a map to hold the form data
    final Map<String, dynamic> gardeningData = {
      'type': gardeningService,
      'area': area,
      'types_property': propertyType,
      'app_date': appointmentDate?.toIso8601String().split('T')[0], // Convert to string
      'preferred_time': appointmentTime,
      'details': additionalDetails,
      'photo': uploadedPhotos.isNotEmpty 
      ? uploadedPhotos.map((file) => file.path).toList() 
      : [], // Ensure an empty array for photos
      'budget': budget,
      'address': address,
    };

    // Print the form data for debugging
    print('Form Data: $gardeningData');

    // Show a loading indicator
    EasyLoading.showToast('Booking...');

    try{
     bool success = await Provider.of<OrderProvider>(context, listen: false)
          .storeGardeningDetail(gardeningData, context);

      if (success) {
        EasyLoading.showToast('Booked Successfully!');

        Navigator.pushReplacementNamed(
          context,
          Routes.getOrderConfirmationRoute(
            'product', // Pass the "comeFrom" argument
            isWiring: false, // Specify the relevant flag
            isPiping: false, // Specify the relevant flag
            isGardening: true, // Specify the relevant flag
            isRunner: false, // Specify the relevant flag
            detailData: gardeningData,
          ),
        );
      } else {
        EasyLoading.showToast('Failed to book gardening service.');
      }
    } catch (e) {
      EasyLoading.showToast('An error occurred: $e');
    }
    
    } else {
      EasyLoading.showToast('Please fill in all the fields!');
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return getProductInformation();
    });
  }

  getProductInformation() {
    if (widget.isCart == "true") {
      product = cart_prov.getCartProductList
          .firstWhere((element) => element.id.toString() == widget.productID);
    } else if (widget.isSearch == "true") {
      product = product_prov.productListSearch
          .firstWhere((element) => element.id.toString() == widget.productID);
    } else {
      product = product_prov.productList
          .firstWhere((element) => element.id.toString() == widget.productID);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> addToCart() async {
    Navigator.pop(context);
    EasyLoading.show(status: 'loading...');
    Cart cart = Cart();
    cart.productId = product.id;
    cart.quantity = cartQuantity;
    cart.dateAdded = DateTime.now();
    cart.isPurchase = "false";
    cart.isCart = true;
    await cart_prov.addToCart(context, cart);
    EasyLoading.dismiss();
  }

  void checkout() {
    Navigator.pop(context);
    Cart cart = Cart();
    cart.productId = product.id;
    cart.quantity = cartQuantity;
    cart.price = product.price;
    cart.dateAdded = DateTime.now();
    cart.isPurchase = "false";
    cart.isCart = false;
    cart_prov.addCartList(cart);
    // Navigator.pushNamed(context, Routes.getOrderConfirmationRoute(
    //   "product", 
    //   isWiring: false, 
    //   isPiping: false, 
    //   isGardening: true, 
    //   isRunner: false))
    //     .then((value) {
    //   if (value == true) {
    //     cart_prov.clearCartList();
    //     getProductInformation();
    //   }
    //   ;
    // });
  }

  void showModalBottom(int index, BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 10.0),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CachedNetworkImage(
                          filterQuality: FilterQuality.high,
                          imageUrl: "${product.imageURL!}",
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
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
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 19,
                                  color: ColorResources.COLOR_BLACK
                                      .withOpacity(0.9)),
                            ),
                            Text(
                              "Inventory: ${product.quantity}",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: ColorResources.COLOR_BLACK
                                      .withOpacity(0.7)),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "RM ${product.price!.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 19,
                                  color: ColorResources.COLOR_BLACK
                                      .withOpacity(0.8)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Expanded(child: Container()),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      Text(
                        "Enter the quantity: ",
                        style: TextStyle(fontSize: 14),
                      ),
                      InputQty.int(
                        decoration: QtyDecorationProps(
                          isBordered: false,
                          borderShape: BorderShapeBtn.none,
                          btnColor: ColorResources.COLOR_PRIMARY,
                          width: 12,
                          plusBtn: Icon(
                            Icons.add_box_outlined,
                            size: 25,
                            color: ColorResources.COLOR_PRIMARY,
                          ),
                          minusBtn: Icon(
                            Icons.indeterminate_check_box_outlined,
                            size: 25,
                            color: ColorResources.COLOR_PRIMARY,
                          ),
                        ),
                        //Need Change
                        maxVal: product.quantity!,
                        initVal: cartQuantity,
                        minVal: 1,
                        steps: 1,
                        onQtyChanged: (val) {
                          setState(() {
                            cartQuantity = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                CustomButton(
                  btnTxt: index == 0 ? 'Add to cart' : 'Checkout',
                  onTap: () async {
                    if (index == 0) await addToCart();
                    if (index == 1) checkout();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Gardening Service'),
        backgroundColor: ColorResources.COLOR_PRIMARY,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _submitForm();
                },
                child: Container(
                  color: ColorResources.COLOR_PRIMARY,
                  height: 60,
                  child: Center(
                    child: Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Requirements',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)
                      ),

                  //service Image Section
                  Center(
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.high,
                      imageUrl: "${product.imageURL!}",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200, // Set the desired height
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill, // Adjust fit as per your requirements
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          width: double.infinity,
                          height: 200, // Same height as the image container
                          color: Colors.grey[400],
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 50, // Adjust size if necessary
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "View Pricing" Button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isPricingVisible = !_isPricingVisible; // Toggle visibility
                      });
                    },
                    child: Text(_isPricingVisible ? "Hide Pricing" : "View Pricing"),
                  ),
                  const SizedBox(height: 20),

                  // Pricing Image Section
                  if (_isPricingVisible) 
                    // Pricing Image Section
                    Center(
                      child: Image.asset(
                        'assets/image1.jpg', // Replace with your image asset
                        height: 200,
                      ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // Gardening Service Type
                  Text('What type of gardening service do you need?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: gardeningService,
                    hint: Text('Select a service'),
                    items: gardeningServiceOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      gardeningService = value;
                    }),
                    validator: (value) =>
                        value == null ? 'Please select a service' : null,
                  ),
                  const SizedBox(height: 20),

                  // Fixes
                  Text('How big is your area?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: area,
                    hint: Text('Select area'),
                    items: areaOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      area = value;
                    }),
                    validator: (value) =>
                        value == null ? 'Please select area' : null,
                  ),
                  const SizedBox(height: 20),

                  // Property Type
                  Text('Types of Property',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: propertyType,
                    hint: Text('Select property type'),
                    items: propertyTypeOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      propertyType = value;
                    }),
                    validator: (value) =>
                        value == null ? 'Please select property type' : null,
                  ),
                  const SizedBox(height: 20),

                  // Preferred Appointment Date
                  Text('Preferred Appointment Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _selectAppointmentDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        appointmentDate == null
                            ? 'Select a date'
                            : appointmentDate.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Appointment Time
                  Text('Preferred Appointment Time',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: appointmentTime,
                    hint: Text('Select a time slot'),
                    items: appointmentTimeOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      appointmentTime = value;
                    }),
                    validator: (value) =>
                        value == null ? 'Please select a time' : null,
                  ),
                  const SizedBox(height: 20),

                  // Additional Details
                  Text('Any more details? (Optional)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  TextFormField(
                    maxLines: 3,
                    onChanged: (value) => additionalDetails = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Describe any additional details here...',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Photo Upload Section
                  Text('Any photo for reference? (Optional)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...uploadedPhotos.asMap().entries.map((entry) {
                        int index = entry.key;
                        File photo = entry.value;
                        return Stack(
                          children: [
                            Image.file(
                              photo,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _removePhoto(index),
                                child: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                      GestureDetector(
                        onTap: _pickPhoto,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey[200],
                          child: const Icon(Icons.add, size: 32),
                        ),
                      ),
                    ],
                  ),
                  

                  const SizedBox(height: 20),

                  // Address
                  Text('Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  TextFormField(
                    maxLines: 3,
                    onChanged: (value) => address = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your address here...', 
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your address' : null,
                  ),

                  const SizedBox(height: 20),

                  // Budget
                  Text('Your Budget',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: budget,
                    hint: Text('Select budget range'),
                    items: budgetOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      budget = value;
                    }),
                    validator: (value) =>
                        value == null ? 'Please select a budget' : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}