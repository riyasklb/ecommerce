import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 475,
                  height: 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(product.image), // Load image from URL
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title.split(' ').length > 3
                        ? product.title.split(' ').sublist(0, 2).join(' ') +
                            '...'
                        : product.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${product.price.toString()} \$',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFBB56), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    product.rating.rate.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFFBB56),
                    ),
                  ),
                  const SizedBox(width: 17),
                  Text(
                    '( ${product.rating.count} reviews )', // Show number of reviews
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Choose Size",
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(children: [
                _buildSizeOption("18 cm", false),
                _buildSizeOption("20 cm", true), // Selected size
                _buildSizeOption("24 cm", false),
                _buildSizeOption("30 cm", false),
              ]),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: GoogleFonts.montserrat(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: GoogleFonts.montserrat(
                    fontSize: 13, color: Color(0x66000000)),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7), // light gray background
                  borderRadius: BorderRadius.circular(10), // rounded corners
                ),
                child: IconButton(
                  icon: Icon(Icons.favorite_border,
                      color: Colors.black, size: 24),
                  onPressed: () {
                    // Handle favorite action
                  },
                ),
              ),
              SizedBox(width: 8), // Add spacing between the buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB08888), // Button color #B08888
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 80, vertical: 18), // Adjust padding
                ),
                onPressed: () {
                  
                  // Handle add to cart action
                },
                child: Text(
                  "Add to cart",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
        ));
  }

  Widget _buildSizeOption(String size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFB08888) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          size,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Color(0x66000000),
          ),
        ),
      ),
    );
  }
}
