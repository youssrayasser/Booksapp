import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bookdescription.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> genres = [
    'All Genres',
    'Romance',
    'Fiction',
    'Non Fiction',
    'Sci-Fi',
    'Mystery',
    'Fantasy',
    'Biography'
  ];

  final List<Map<String, String>> trendingBooks = [
    {'genre': 'Romance', 'image': 'assets/images/romance_book.jpg'},
    {'genre': 'Historical', 'image': 'assets/images/historical_book.jpg'},
    {'genre': 'Sci-Fi', 'image': 'assets/images/scifi_book.jpeg'},
    {'genre': 'Mystery', 'image': 'assets/images/mystery_book.jpeg'},
  ];

  final List<Map<String, String>> famousBooks = [
    {
      'title': 'The Great Gatsby',
      'image': 'assets/images/gatsby.jpg',
      'description':
      'The Great Gatsby may be the most popular classic in modern American fiction. Since its publication in 1925, Fitzgerald\'s masterpiece has become a touchstone for generations of readers and writers, many of whom reread it every few years as a ritual of imaginative renewal. The story of Jay Gatsby\'s desperate quest to win back his first love reverberates with themes at once characteristically American and universally human, among them the importance of honesty, the temptations of wealth, and the struggle to escape the past. Though The Great Gatsby runs to fewer than two hundred pages, there is no bigger read in American literature.'
    },
    {
      'title': 'Pride and Prejudice',
      'image': 'assets/images/pride.jpg',
      'description': 'A classic novel of manners by Jane Austen.'
    },
    {
      'title': 'Hunger Games',
      'image': 'assets/images/hungergames.jpg',
      'description': 'A thrilling dystopian trilogy by Suzanne Collins.'
    },
    {
      'title': 'Texas Glory',
      'image': 'assets/images/texasglory.jpg',
      'description': 'A historical romance set in Texas.'
    },
    {
      'title': 'Harry Potter',
      'image': 'assets/images/harrypotter.jpg',
      'description': 'The wizarding world begins with the boy who lived.'
    },
  ];

  final List<Map<String, String>> authors = [
    {'name': 'Tessa Dare', 'image': 'assets/images/tessa_dare.jpg'},
    {'name': 'Cora Riley', 'image': 'assets/images/cora_riley.jpeg'},
    {'name': 'J.K. Rowling', 'image': 'assets/images/jk_rowling.jpg'},
    {'name': 'Lisa Kleypas', 'image': 'assets/images/lisa_kleypas.jpg'},
    {'name': 'John Green', 'image': 'assets/images/john_green.jpg'},
    {'name': 'Stephen Chbosky', 'image': 'assets/images/stephen_chbosky.jpg'},
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: genres.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _authorItem(String imagePath, String name) {
    return Container(
      width: 90,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage(imagePath),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _trendingBookItem(Map<String, String> item) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(item['image']!),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(item['genre']!),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.bell, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Trending Books',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: trendingBooks.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return _trendingBookItem(item);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Genre Tabs
            Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: genres.map((genre) => Tab(text: genre)).toList(),
              ),
            ),

            SizedBox(height: 10),

            // Recommended Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended For You',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Famous Books List
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: famousBooks.length,
                itemBuilder: (context, index) {
                  final book = famousBooks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDescriptionScreen(
                            title: book['title']!,
                            image: book['image']!,
                            description: book['description']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 130,
                      margin: EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                book['image']!,
                                fit: BoxFit.cover,
                                width: 130,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            book['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Authors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Authors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),

            Container(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: authors.length,
                itemBuilder: (context, index) {
                  final author = authors[index];
                  return _authorItem(author['image']!, author['name']!);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart), label: 'Favourite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
