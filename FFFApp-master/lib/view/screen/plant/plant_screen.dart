import 'package:flutter/material.dart';
import 'package:FFF/view/screen/sos_button.dart'; // Correct import for the current structure
import 'package:FFF/util/color_resources.dart';
import 'package:FFF/view/screen/emergency_screen.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorResources.COLOR_PRIMARY,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/image/fff_icon.png', // Replace with your logo asset
                  height: 40,
                  width: 40,
                ),
                const SizedBox(width: 10),
                const Text(
                  "FixIt and Foliage Frenzy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add emergency button functionality
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     shape: CircleBorder(),  // Use CircleBorder for a circular shape
            //     padding: EdgeInsets.all(24),  // Adjust padding to control the size
            //   ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20),
                // ),
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 10.0,  // Reduced vertical padding
              //     horizontal: 10.0, // Reduced horizontal padding
              //   ),
              //   minimumSize: Size(70, 30),  // Optional: Set a minimum width and height
              // ),
            //   child: const Text(
            //     "EMERGENCY",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 8,
            //     ),
            //    textAlign: TextAlign.center,  // Center the text
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     gradient: LinearGradient(
            //       colors: [Colors.red, Colors.redAccent],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //   ),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Add emergency button functionality
            //     },
            //     style: ElevatedButton.styleFrom(
            //       shape: CircleBorder(),
            //       padding: EdgeInsets.all(10),  // Adjust padding to control the size
            //       backgroundColor: Colors.transparent,  // Make button background transparent
            //       shadowColor: Colors.transparent,  // Remove button shadow
            //     ),
            //     child: const Text(
            //       "SOS",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,  // Adjust font size as needed
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            SOSButton(
              onPressed: () {
                // Handle SOS button press
                print("SOS button pressed!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              const Text(
                "Exactly What You Need",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              // const Text(
              //   "Exactly What You Need",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.black87,
              //   ),
              // ),
              const SizedBox(height: 16),

              // Description Section
              const Text(
                "Through this system, it provides a centralized and efficient solution for connecting individuals in need of various services with qualified workers capable of fulfilling those requests. The platform addresses the needs of users such as the elderly, people with disabilities, or those living alone who require assistance with tasks ranging from household chores to specialized services.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Discover Button with Image
              Center(
                child: InkWell(
                  onTap: () {
                    // Add action here when the image is tapped
                    // For example, you can navigate to another screen
                  },
                  child: Image.asset(
                    'assets/image/service.jpg', // Path to your image
                    width: 600, // Set desired width
                    height: 400, // Set desired height
                    fit: BoxFit.contain, // Adjust how the image fits
                  ),
                ),
              ),
              // New "Why Choose Us?" Section
              const SizedBox(height: 20), // Add space before the new section
              const Text(
                "Why Choose Us?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.star_rounded, size: 30, color: Colors.yellow), // Icon
                  const SizedBox(width: 10),
                  const Expanded( // Use Expanded to allow text to wrap
                    child: Text(
                      "We provide reliable and efficient services tailored to your needs, ensuring satisfaction and peace of mind.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add space between rows
              Row(
                children: [
                  Icon(Icons.thumb_up_rounded, size: 30, color: Colors.red), // Second Icon
                  const SizedBox(width: 10),
                  const Expanded( // Use Expanded to allow text to wrap
                    child: Text(
                      "Our team is dedicated to providing top-notch customer service and support.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add space between rows
              Row(
                children: [
                  Icon(Icons.shield_rounded, size: 30, color: Colors.grey), // Second Icon
                  const SizedBox(width: 10),
                  const Expanded( // Use Expanded to allow text to wrap
                    child: Text(
                      "Get protected by warranty and insurance.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
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
