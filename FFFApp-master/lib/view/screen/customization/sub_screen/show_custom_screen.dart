import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nurserygardenapp/providers/customize_provider.dart';
import 'package:nurserygardenapp/util/color_resources.dart';
import 'package:nurserygardenapp/util/custom_text_style.dart';
import 'package:nurserygardenapp/util/routes.dart';
import 'package:nurserygardenapp/view/base/custom_appbar.dart';
import 'package:nurserygardenapp/view/base/custom_button.dart';
import 'package:nurserygardenapp/view/screen/customization/widget/video_items.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ShowCustomScreen extends StatefulWidget {
  const ShowCustomScreen({super.key});

  @override
  State<ShowCustomScreen> createState() => _ShowCustomScreenState();
}

class _ShowCustomScreenState extends State<ShowCustomScreen> {
  late CustomizeProvider custom_prov =
      Provider.of<CustomizeProvider>(context, listen: false);

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: CustomAppBar(
          isBgPrimaryColor: true,
          title: 'Your Selected Style',
          isBackButtonExist: false,
          context: context,
          isCenter: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '5: Play the video to see the style you have selected.',
                          style: CustomTextStyles(context).titleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Consumer<CustomizeProvider>(
                    builder: (context, customProvider, child) {
                  if (customProvider.isFetching) {
                    return Container(
                        height: size.height,
                        width: size.width,
                        child: Center(
                          child: LoadingAnimationWidget.inkDrop(
                              color: ColorResources.COLOR_PRIMARY, size: 43),
                        ));
                  } else {
                    return Container(
                      height: size.height * 0.6,
                      width: size.width,
                      child: VideoItems(
                        videoPlayerController: VideoPlayerController.networkUrl(
                          Uri.parse(
                            customProvider.item_url.toString(),
                          ),
                          videoPlayerOptions: VideoPlayerOptions(
                            mixWithOthers: false,
                            allowBackgroundPlayback: false,
                          ),
                        ),
                        looping: false,
                        autoplay: true,
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                      width: 90,
                      child: CustomButton(
                        btnTxt: 'Checkout',
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.getCustomizeConfirmationRoute());
                        },
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
