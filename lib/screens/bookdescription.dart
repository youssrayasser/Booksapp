import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookDescriptionScreen extends StatefulWidget {
  final String title;
  final String image;
  final String description;

  const BookDescriptionScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  _BookDescriptionScreenState createState() => _BookDescriptionScreenState();
}

class _BookDescriptionScreenState extends State<BookDescriptionScreen> {
  final int bookPrice = 7; // example fixed price

  bool isFavorite = false;
  bool isInCart = false;

  void addToCart() {
    if (!isInCart) {
      setState(() {
        isInCart = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.title} added to cart')),
      );
    }
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite
            ? '${widget.title} added to favorites'
            : '${widget.title} removed from favorites'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        // Removed favorite and cart icons from app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(widget.image, height: 250, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heart Icon Button
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.heart,
                    color: isFavorite ? Colors.red : Colors.black,
                    size: 30,
                  ),
                  onPressed: toggleFavorite,
                ),
                SizedBox(width: 40),
                // Add to Cart Button
                ElevatedButton(
                  onPressed: addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                    EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isInCart ? 'Added to Cart' : 'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
