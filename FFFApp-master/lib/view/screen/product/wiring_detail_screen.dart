import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:FFF/data/model/cart_model.dart';
import 'package:FFF/data/model/product_model.dart';
// import 'package:FFF/data/model/wiring_detail_model.dart';
import 'package:FFF/providers/cart_provider.dart';
import 'package:FFF/providers/order_provider.dart';
import 'package:FFF/providers/product_provider.dart';
import 'package:FFF/util/color_resources.dart';
// import 'package:FFF/util/custom_text_style.dart';
import 'package:FFF/util/dimensions.dart';
import 'package:FFF/util/routes.dart';
import 'package:FFF/view/base/custom_button.dart';
// import 'package:FFF/view/base/custom_space.dart';
// import 'package:FFF/view/base/image_enlarge_widget.dart';
// import 'package:FFF/view/base/page_loading.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:FFF/providers/wiringdetail_provider.dart';

class WiringDetailScreen extends StatefulWidget {
  final String productID;
  final String isCart;
  final String isSearch;
  const WiringDetailScreen({
    required this.productID,
    required this.isCart,
    required this.isSearch,
    super.key,
  });

  @override
  State<WiringDetailScreen> createState() => _WiringDetailScreenState();
}

class _WiringDetailScreenState extends State<WiringDetailScreen> {
  late var product_prov = Provider.of<ProductProvider>(context, listen: false);
  late var cart_prov = Provider.of<CartProvider>(context, listen: false);
  late Product product = Product();
  bool isLoading = true;
  int cartQuantity = 1;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form fields
  String? electricalService;
  bool _isPricingVisible = false;
  List<String> fixes = [];
  String? hasParts;
  String? propertyType;
  DateTime? appointmentDate;
  String? appointmentTime;
  String? additionalDetails;
  List<File> uploadedPhotos = []; // Updated for photo uploads
  String? budget;
  String? address;

  // Dummy data
  final List<String> electricalServiceOptions = [
    'Installation',
    'Maintenance',
    'Repair',
    'Inspection'
  ];
  final List<String> fixesOptions = [
    'Light Bulb',
    'Wiring',
    'Fuse Box',
    'Switches',
    'Outlets',
    'Ceiling Fan',
    'Generator',
    'Other (Explain in Additional Details)'
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
     final List<XFile>? photos = await picker.pickMultiImage(); // Allow multiple image selection
     if (photos != null && photos.isNotEmpty) {
       setState(() {
         uploadedPhotos.clear(); // Clear previous photos if needed
         uploadedPhotos.addAll(photos.map((file) => File(file.path)).toList()); // Add selected photos
       });
     }
   }

  void _removePhoto(int index) {
    setState(() {
      uploadedPhotos.removeAt(index);
    });
  }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //   print ('uploadedPhotos[]');
  //     // Create a WiringModel instance
  //     WiringModel wiringModel = WiringModel(
  //       success: true,
  //       data: Data(
  //         type: electricalService,
  //         fixitem: fixes[],
  //         ishavepart: hasParts,
  //         typesProperty: propertyType,
  //         appDate: appointmentDate,
  //         preferredTime: appointmentTime,
  //         details: additionalDetails,
  //         photo: uploadedPhotos[],
  //         photoUrl: photoUrl[],
  //         budget: budget,
  //       ),
  //     );

  //     // Call your provider to submit the data
  //     Provider.of<WiringProvider>(context, listen: false).submitWiringDetails(wiringModel).then((success) {
  //       if (success) {
  //         EasyLoading.showToast('Wiring details submitted successfully!');
  //         Navigator.pop(context); // Navigate back or to another screen
  //       } else {
  //         EasyLoading.showToast('Failed to submit wiring details.');
  //       }
  //     });
  //   } else {
  //     EasyLoading.showToast('Please fill in all the fields!');
  //   }
  // }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Form data is saved, you can process it here.
      // print('Form Submitted Successfully');
      // print('Electrical Service: $electricalService');
      // print('Fixes: $fixes');
      // print('Has Parts: $hasParts');
      // print('Property Type: $propertyType');
      // print('Appointment Date: $appointmentDate');
      // print('Appointment Time: $appointmentTime');
      // print('Additional Details: $additionalDetails');
      // print('Uploaded Photos: $uploadedPhotos');
      // print('Budget: $budget');

      

      //WiringModel wiringModel = WiringModel(
  //       success: true,
  //       data: Data(
  //         type: electricalService,
  //         fixitem: fixes[],
  //         ishavepart: hasParts,
  //         typesProperty: propertyType,
  //         appDate: appointmentDate,
  //         preferredTime: appointmentTime,
  //         details: additionalDetails,
  //         photo: uploadedPhotos[],
  //         photoUrl: photoUrl[],
  //         budget: budget,
  //       ),
  //     );

  //     // Call your provider to submit the data
  //     Provider.of<WiringProvider>(context, listen: false).submitWiringDetails(wiringModel).then((success) {
  //       if (success) {
  //         EasyLoading.showToast('Wiring details submitted successfully!');
  //         Navigator.pop(context); // Navigate back or to another screen
  //       } else {
  //         EasyLoading.showToast('Failed to submit wiring details.');
  //       }
  //     });
  //   } else {
  //     EasyLoading.showToast('Please fill in all the fields!');
  //   }
  
    List<String> imageNames = [];
    // Prepare image names for storage
    if (uploadedPhotos.isNotEmpty) {
      imageNames = uploadedPhotos.map((file) {
        String imageName = file.path.split('/').last; // Extract the file name
        return imageName;
      }).toList();
    } 


    // Create a map to hold the form data
    final Map<String, dynamic> wiringData = {
      'type': electricalService,
      'fixitem': fixes,
      'ishavepart': hasParts == 'Yes', // Convert to boolean
      'types_property': propertyType,
      'app_date': appointmentDate?.toIso8601String().split('T')[0], // Convert to string
      'preferred_time': appointmentTime,
      'details': additionalDetails?.isNotEmpty == true ? additionalDetails : null,
      'photo': imageNames.isNotEmpty ? imageNames.join(',') : 'no_service.png',
      'budget': budget,
      'address': address,
      'prod_id': widget.productID,
    };

    // Print the form data for debugging
    print('Form Data: $wiringData');

    // Show a loading indicator
    EasyLoading.showToast('Booking...');

    try{
     bool success = await Provider.of<OrderProvider>(context, listen: false)
          .storeWiringDetail(wiringData, context);

      if (success) {        
        if(uploadedPhotos.isNotEmpty){
          bool uploadSuccess = await _uploadPhotos();
          if(uploadSuccess){     
            EasyLoading.showToast('Booked Successfully with Photo!');

            Navigator.pushReplacementNamed(
              context,
              Routes.getOrderConfirmationRoute(
                "product", 
                isWiring: true, 
                isPiping: false, 
                isGardening: false, 
                isRunner: false,
                detailData: wiringData,
              ),
            );
          }
        }else{
          EasyLoading.showToast('Booked Successfully!');

            Navigator.pushReplacementNamed(
              context,
              Routes.getOrderConfirmationRoute(
                "product", 
                isWiring: true, 
                isPiping: false, 
                isGardening: false, 
                isRunner: false,
                detailData: wiringData,
              ),
            );
        }
      } else {
        EasyLoading.showToast('Failed to book wiring service.');
      }
    } catch (e) {
      EasyLoading.showToast('An error occurred: $e');
    }
    
    } else {
      EasyLoading.showToast('Please fill in all the fields!');
    }


    // Call your provider to submit the data
    // Provider.of<OrderProvider>(context, listen: false)
    //     .storeWiringDetail(wiringData, address)
    //     .then((success) {
    //   if (success) {
    //     EasyLoading.showToast('Wiring details submitted successfully!');
    //     Navigator.pop(context); // Navigate back or to another screen
    //   } else {
    //     EasyLoading.showToast('Failed to submit wiring details.');
    //   }
    // });

    //   Navigator.pop(context);
      // Cart cart = Cart();
      // cart.productId = product.id;
      // cart.quantity = cartQuantity;
      // cart.price = product.price;
      // cart.dateAdded = DateTime.now();
      // cart.isPurchase = "false";
      // cart.isCart = false;
      // cart_prov.addCartList(cart);
    //   Navigator.pushNamed(context, Routes.getOrderConfirmationRoute("product"))
    //       .then((value) {
    //     if (value == true) {
    //       // cart_prov.clearCartList();
    //       getProductInformation();
    //     }
    //     ;
    //   });
    // } else {
    //   EasyLoading.showToast('Please fill in all the fields!');
    // }
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

  Future<bool> _uploadPhotos() async {
    EasyLoading.show(status: 'Uploading photos...');
    try {
        // Ensure that the key 'photos' is used for the list of files
        bool uploadSuccess = await Provider.of<OrderProvider>(context, listen: false)
            .uploadServiceImages(uploadedPhotos, 'photos', context);

        if (uploadSuccess) {
            print('Photos uploaded successfully!');
            return true;
        } else {
            print('Failed to upload photos.');
            return false;
        }
    } catch (e) {
        print('An error occurred: $e');
        return false;
    } finally {
        EasyLoading.dismiss();
    }
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
    //   isWiring: true, 
    //   isPiping: false, 
    //   isGardening: false, 
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
    //final wiring_prov = Provider.of<WiringDetailProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white, // <-- SEE HERE

            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context,
                  Routes.getDashboardRoute("Services"), (route) => false);
            },),
            backgroundColor: ColorResources.COLOR_PRIMARY,
            title: const Text('Electrical and Wiring Service'),
        ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _submitForm();

                  // if(_formKey.currentState!.validate()){
                  //   _submitForm();
                  //   EasyLoading.showToast('Added to cart!');
                  // }else{
                  //   EasyLoading.showToast('Please fill in all the fields!');
                  // }
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
            // Expanded(
            //   child: GestureDetector(
            //     onTap: _submitForm,
            //     child: Container(
            //       color: Colors.green,
            //       height: 60,
            //       child: Center(
            //         child: Text(
            //           'Buy Now',
            //           style: TextStyle(color: Colors.white, fontSize: 16),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Image.asset(
                        'assets/image/pricing/wiring.png', // Replace with your image asset
                        height: 800, // Set a reasonable height
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // Electrical Service Type
                  Text('What type of electrical service do you need?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: electricalService,
                    hint: Text('Select a service'),
                    items: electricalServiceOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      electricalService = value;
                    }),
                    validator: (value) =>
                        value == null ? 'Please select a service' : null,
                  ),
                  const SizedBox(height: 20),

                  // Fixes
                  Text('What do you need to fix?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: fixesOptions
                        .map((e) => FilterChip(
                              label: Text(e),
                              selected: fixes.contains(e),
                              onSelected: (isSelected) {
                                setState(() {
                                  isSelected
                                      ? fixes.add(e)
                                      : fixes.remove(e);
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Do you have the parts?
                  Text('Do you already have the parts?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('Yes'),
                          value: 'Yes',
                          groupValue: hasParts,
                          onChanged: (value) => setState(() {
                            hasParts = value;
                          }),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text('No'),
                          value: 'No',
                          groupValue: hasParts,
                          onChanged: (value) => setState(() {
                            hasParts = value;
                          }),
                        ),
                      ),
                    ],
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