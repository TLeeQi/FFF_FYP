import 'package:flutter/material.dart';
import 'package:FFF/util/custom_text_style.dart';
import 'package:FFF/view/base/custom_appbar.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'FAQs',
        context: context,
        isBackButtonExist: false,
        isBgPrimaryColor: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              FAQItem(
                  title: "How do I book a service?",
                  des:
                      "You can book a service by selecting the desired service category (piping, wiring, gardening, or runner service), browsing through the available providers, and choosing a convenient date and time. Confirm your booking by making the payment through our secure payment gateway."),
              FAQItem(
                  title: "Can I cancel an order?",
                  des:
                      "Yes, you can cancel an order before you pay. To cancel an order, please go to Orders, select the To Pay, and click Cancel Order."),
              FAQItem(
                  title: "How do I know if the service provider is trustworthy?",
                  des:
                      "Yes, All service providers undergo a rigorous vetting process, including background checks and verification of qualifications. You can also view their ratings, reviews, and past work from other users."),
              FAQItem(
                  title: "Can I change an address?",
                  des:
                      "Yes, you can change an address before your order paid. To change an address, please go to Orders, select the 'preparing', and click Change Address."),
              FAQItem(
                  title: "How can I track my order?",
                  des:
                      "You can track your order in Orders and Delivery page. If you have any questions, please contact us."),
              FAQItem(
                  title: "Is my personal information secure?",
                  des:
                      "Yes, we prioritize the security and privacy of our users. Our app uses advanced encryption and security protocols to protect your personal information and payment details."),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String title;
  final String des;
  const FAQItem({super.key, required this.title, required this.des});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyles(context).titleStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Text(
            des,
            style: CustomTextStyles(context).subTitleStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
