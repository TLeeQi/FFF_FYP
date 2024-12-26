import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VendorDetailScreen extends StatefulWidget {
  final int vendorId;

  const VendorDetailScreen({Key? key, required this.vendorId}) : super(key: key);

  @override
  _VendorDetailScreenState createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  Map<String, dynamic>? vendorDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVendorDetails();
  }

  Future<void> fetchVendorDetails() async {
    try {
      final response = await http.get(
        Uri.parse(dotenv.get('APP_BASE_URL') + '/api/v1/vendor/${widget.vendorId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          vendorDetails = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load vendor details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : vendorDetails == null
              ? Center(child: Text('No details available'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendorDetails!['name'] ?? 'No Name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Rating: ${vendorDetails!['rating']?.toStringAsFixed(1) ?? 'N/A'}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Address: ${vendorDetails!['address'] ?? 'No Address'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: vendorDetails!['ratings']?.length ?? 0,
                          itemBuilder: (context, index) {
                            final rating = vendorDetails!['ratings'][index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 4.0),
                              child: ListTile(
                                title: Text('Rating: ${rating['rating']}'),
                                subtitle: Text(rating['review'] ?? 'No Review'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
