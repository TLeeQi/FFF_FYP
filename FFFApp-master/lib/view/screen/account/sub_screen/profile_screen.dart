import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FFF/data/model/user_model.dart';
import 'package:FFF/providers/user_provider.dart';
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/util/custom_text_style.dart';
import 'package:FFF/util/dimensions.dart';
import 'package:FFF/util/images.dart';
import 'package:FFF/view/base/custom_button.dart';
import 'package:FFF/view/base/custom_space.dart';
import 'package:FFF/view/base/custom_textfield.dart';
import 'package:FFF/view/base/upload_image_widget.dart';
import 'package:FFF/view/screen/account/widget/empty_account_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProvider user_prov =
      Provider.of<UserProvider>(context, listen: false);
  String profileHeader = "";
  GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  String _countryDialCode = "+60";
  String _profileImage = "null";
  String _imageName = "";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();

  String _selectedDate = "";
  DateTime dateTime = DateTime.now();
  var dateFormat = DateFormat('yyyy-MM-dd');

  List<String> _gender = [
    'Male',
    'Female',
  ];

  DateTime oldDate = DateTime.now();

  late var _selectedGender = _gender[0];

  void _presentDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(1923, 1, 1);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1973, 1, 1),
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      if (pickedDate == null) return;
      dateTime = pickedDate;
      _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserInformation();
    });
  }

  Future<void> _getUserInformation() async {
    bool isSuccessful = await user_prov.showUserInformation(context);
    if (context.mounted) {
      if (isSuccessful) {
        debugPrint("User Name: " + user_prov.userModel.data!.name!);
        setState(() {
          dateTime = user_prov.userModel.data!.birthDate ?? DateTime.now();
          oldDate = dateTime;
          profileHeader = user_prov.userModel.data!.name ?? "User";
          profileHeader = profileHeader + "\'s Profile";
          _nameController.text = user_prov.userModel.data!.name ?? "";
          _selectedGender = user_prov.userModel.data!.gender ?? "Male";
          _emailController.text = user_prov.userModel.data!.email ?? "";
          _phoneController.text = user_prov.userModel.data!.contactNumber ?? "";
          _profileImage =
              user_prov.userModel.data!.image_url ?? Images.profile_header;
          _selectedDate = user_prov.userModel.data!.birthDate == null
              ? "Please enter your birth date"
              : DateFormat('yyyy-MM-dd')
                  .format(user_prov.userModel.data!.birthDate!)
                  .toString();
        });
      }
    }
  }

  _handleSubmission() async {
    if (_formKey!.currentState!.validate()) {
      UserData uInfo = UserData();
      uInfo.name = _nameController.text;
      uInfo.email = _emailController.text;
      uInfo.contactNumber = _phoneController.text;
      uInfo.gender = _selectedGender;
      uInfo.contactNumber = _phoneController.text;
      uInfo.image_url = _profileImage;
      uInfo.image = _imageName;
      uInfo.birthDate =
          user_prov.userModel.data!.birthDate == null && dateTime == oldDate
              ? null
              : dateTime;
      bool isSuccessful = await user_prov.updateUserProfile(context, uInfo);
      if (isSuccessful) {
        Navigator.pop(context, true);
      }
    }
  }

  _handleImage(String name, String result, String imageName) {
    setState(() {
      if (name == 'avatar') {
        _profileImage = result;
        _imageName = imageName;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.COLOR_PRIMARY,
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
        centerTitle: true,
        title: Text(
          profileHeader,
          style: CustomTextStyles(context).subTitleStyle.copyWith(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return userProvider.isLoading
              ? EmptyAccountWidget()
              // ignore: deprecated_member_use
              : WillPopScope(
                  onWillPop: () async {
                    return !(userProvider.isLoading ||
                            userProvider.isSubmitting ||
                            userProvider.isUploading);
                  },
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 160,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    Images.profile_bg),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                        Positioned(
                                          left: 10,
                                          top: 100,
                                          child: UploadImageWidget(
                                              name: "avatar",
                                              imageUrl: _profileImage,
                                              resultUrl: (String name,
                                                  String url,
                                                  String imageName) {
                                                _handleImage(
                                                    name, url, imageName);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalSpacing(
                                    height: 10,
                                  ),
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        color:
                                            ColorResources.COLOR_GREY_CHATEAU),
                                  ),
                                  VerticalSpacing(),
                                  CustomTextField(
                                    hintText: "Please enter your name",
                                    isShowBorder: true,
                                    isShowPrefixIcon: true,
                                    prefixIconUrl: Icon(
                                      Icons.perm_identity_rounded,
                                      color: Colors.grey,
                                    ),
                                    focusNode: _nameFocus,
                                    nextFocus: _emailFocus,
                                    controller: _nameController,
                                    inputType: TextInputType.text,
                                  ),
                                  VerticalSpacing(
                                    height: 16,
                                  ),
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                        color:
                                            ColorResources.COLOR_GREY_CHATEAU),
                                  ),
                                  VerticalSpacing(),
                                  Container(
                                    width: double.infinity,
                                    child: CupertinoSlidingSegmentedControl<
                                        String>(
                                      thumbColor:
                                          Theme.of(context).primaryColor,
                                      groupValue: _selectedGender,
                                      onValueChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            _selectedGender = value;
                                          });
                                        }
                                      },
                                      children: {
                                        _gender[0]: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text(
                                            _gender[0],
                                            style: TextStyle(
                                              color: (_selectedGender ==
                                                      _gender[0])
                                                  ? ColorResources.COLOR_WHITE
                                                  : ColorResources.COLOR_GREY,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        _gender[1]: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: Text(
                                            _gender[1],
                                            style: TextStyle(
                                              color: (_selectedGender ==
                                                      _gender[1])
                                                  ? ColorResources.COLOR_WHITE
                                                  : ColorResources.COLOR_GREY,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      },
                                    ),
                                  ),
                                  VerticalSpacing(
                                    height: 16,
                                  ),
                                  // Text(
                                  //   "Email",
                                  //   style: TextStyle(
                                  //       color:
                                  //           ColorResources.COLOR_GREY_CHATEAU),
                                  // ),
                                  // VerticalSpacing(),
                                  // CustomTextField(
                                  //   isReadOnly: true,
                                  //   hintText: "Please enter your email",
                                  //   isShowBorder: true,
                                  //   isShowPrefixIcon: true,
                                  //   prefixIconUrl: Icon(
                                  //     Icons.email_outlined,
                                  //     color: Colors.grey,
                                  //   ),
                                  //   focusNode: _emailFocus,
                                  //   nextFocus: _phoneFocus,
                                  //   controller: _emailController,
                                  //   inputType: TextInputType.emailAddress,
                                  // ),
                                  // VerticalSpacing(
                                  //   height: 16,
                                  // ),
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                        color:
                                            ColorResources.COLOR_GREY_CHATEAU),
                                  ),
                                  VerticalSpacing(),
                                  Row(children: [
                                    CountryCodePicker(
                                      enabled: true,
                                      onChanged: (CountryCode countryCode) {
                                        _countryDialCode =
                                            countryCode.dialCode!;
                                      },
                                      initialSelection: _countryDialCode,
                                      favorite: [_countryDialCode],
                                      showDropDownButton: true,
                                      padding: EdgeInsets.zero,
                                      showFlagMain: true,
                                      dialogBackgroundColor:
                                          Theme.of(context).cardColor,
                                      backgroundColor:
                                          Theme.of(context).cardColor,
                                      textStyle: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .color),
                                    ),
                                    Expanded(
                                        child: CustomTextField(
                                      isApplyValidator: false,
                                      hintText:
                                          "Please enter your phone number",
                                      isShowBorder: true,
                                      isShowPrefixIcon: true,
                                      prefixIconUrl: const Icon(
                                        Icons.phone_outlined,
                                        color: Colors.grey,
                                      ),
                                      controller: _phoneController,
                                      focusNode: _phoneFocus,
                                      inputType: TextInputType.phone,
                                    )),
                                  ]),
                                  VerticalSpacing(
                                    height: 16,
                                  ),
                                  Text(
                                    "Birth Date",
                                    style: TextStyle(
                                        color:
                                            ColorResources.COLOR_GREY_CHATEAU),
                                  ),
                                  VerticalSpacing(),
                                  InkWell(
                                      onTap: () {
                                        _presentDatePicker(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 18),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorResources
                                                  .COLOR_GREY_CHATEAU,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            HorizontalSpacing(
                                              width: 13,
                                            ),
                                            Text(
                                              _selectedDate,
                                              style: _selectedDate ==
                                                      "Please enter your birth date"
                                                  ? TextStyle(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_DEFAULT,
                                                      color: ColorResources
                                                          .COLOR_GREY_CHATEAU)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .displayMedium
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.color,
                                                          fontSize: Dimensions
                                                              .FONT_SIZE_LARGE),
                                            )
                                          ],
                                        ),
                                      )),
                                  VerticalSpacing(),
                                  Container(
                                    height: 50,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          "* Please note that according to PDPA, we will only use your personal data for business purpose.",
                                          style: CustomTextStyles(context)
                                              .subTitleStyle
                                              .copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL,
                                                  color: ColorResources
                                                      .COLOR_GRAY),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Consumer<UserProvider>(
                                      builder: (context, userProvider, child) {
                                    return CustomButton(
                                      btnTxt: 'Save',
                                      onTap: () {
                                        if (userProvider.isSubmitting) return;
                                        _handleSubmission();
                                      },
                                    );
                                  })
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
