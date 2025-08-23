import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cooking_app/pages/prof.dart';
import 'package:cooking_app/pages/favorites.dart';
import 'package:cooking_app/pages/landing.dart';
import 'package:cooking_app/pages/search.dart';
import 'package:cooking_app/pages/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

//App's frosted glowing card on top of the random background
class ScrollableFrostedCard extends StatelessWidget {
  const ScrollableFrostedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('Screen Width: ${size.width}, Screen Height: ${size.height}');

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow layer behind the card
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 650,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.3),
                  blurRadius: 60,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),

          // Frosted glass scrollable card
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: 650),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 850,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Featured Recipes:",
                            style: GoogleFonts.truculenta(
                              fontSize: 80,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  20,
                                  (i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      "Recipe ${i + 1}: [Insert name, content, and initial image posting of recipe here]",
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //EXPLORE BY CATEGORY
                    //SHOULD DIRECT USERS TO THE SEARCH WITH FILTER ALREADY ENABLED
                    Container(
                      width: 650,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Explore by category or diet:",
                            style: GoogleFonts.truculenta(
                              fontSize: 50,
                              color: Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 60),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://zhangcatherine.com/wp-content/uploads/2022/09/dog-cake.jpg',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Desserts",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://static01.nyt.com/images/2024/05/16/multimedia/fs-tandoori-chicken-hmjq/fs-tandoori-chicken-hmjq-mediumSquareAt3X.jpg',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Proteins",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://static.vecteezy.com/system/resources/thumbnails/049/110/238/small_2x/close-up-of-colorful-refreshing-drinks-with-ice-cubes-and-bubbles-perfect-for-summer-and-party-themes-photo.jpeg',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Drinks",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNt7pl88JtgGQ_9zUPouLb8Va_WOl4bkZJPg&s',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Luxurious",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://assets.clevelandclinic.org/transform/40f5393d-e6d3-4968-90f2-cbd894b67779/wholeGrainProducts-842797430-770x533-1_jpg',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Carbs",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://static.vecteezy.com/system/resources/thumbnails/002/454/867/small_2x/chronometer-timer-counter-isolated-icon-free-vector.jpg',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Cheap & Fast",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        'https://png.pngtree.com/png-vector/20190329/ourmid/pngtree-vector-shuffle-icon-png-image_889552.jpg',
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    Text(
                                      "Random Recipe",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //Friends' posts, should be sorted by time
                          SizedBox(height: 70),
                          Divider(color: Colors.black, thickness: 2),
                          SizedBox(height: 20),
                          Text(
                            "Your friends' dishes:",
                            style: GoogleFonts.truculenta(
                              fontSize: 50,
                              color: Colors.blueGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  20,
                                  (i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      "Recipe ${i + 1}: [Insert name, content, and initial image posting of recipe here]",
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//App selects a random background from unsplash upon opening the app
class _BackgroundRNG extends StatefulWidget {
  final List<Widget> children;
  const _BackgroundRNG({required this.children});

  @override
  _BackgroundRNGState createState() => _BackgroundRNGState();
}

class _BackgroundRNGState extends State<_BackgroundRNG> {
  late Future<String> _imageUrlFuture;

  @override
  void initState() {
    super.initState();
    //Loads the image url BEFORE the build()
    //Goes constructor, createState(), initState(), build()
    _imageUrlFuture = fetchRandomImageUrl('food');
    print("Background image url loaded");
  }

  Future<String> fetchRandomImageUrl(String query) async {
    final apiKey = dotenv.env['PEXELS_API'];
    
    // If no API key is available, return a default food image
    if (apiKey == null || apiKey.isEmpty || apiKey == 'your_pexels_api_key_here') {
      return 'https://images.unsplash.com/photo-1504674900240-9a9049b7a57a?w=1200&h=800&fit=crop';
    }
    
    try {
      final url = Uri.parse(
        'https://api.pexels.com/v1/search?query=$query&per_page=30',
      );
      final response = await http.get(url, headers: {'Authorization': apiKey});

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List photos = json['photos'];
        if (photos.isNotEmpty) {
          final randomPhoto = photos[Random().nextInt(photos.length)];
          print('Pexels API response: ${response.statusCode}');
          return randomPhoto['src']['original'];
        }
      }
      print('Pexels API error: ${response.statusCode}');
    } catch (e) {
      print('Error fetching from Pexels: $e');
    }
    
    // Fallback to Unsplash image
    return 'https://images.unsplash.com/photo-1504674900240-9a9049b7a57a?w=1200&h=800&fit=crop';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _imageUrlFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading image
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          //smth went wrong, jus display an amber cheese background
          return Container(
            color: Colors.amber,
            child: Column(children: widget.children),
          );
        } else {
          final imageUrl = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
            padding: const EdgeInsets.all(32),
            child: Column(children: widget.children),
          );
        }
      },
    );
  }
}

class _HomePageState extends State<HomePage> {
  User? get _currentUser => Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _BackgroundRNG(
          children: [
            Text(
              'Welcome, chef ${_currentUser?.email ?? "Guest"}!',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Discover and post your favorite recipes and cooks!',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(height: 35),
            ScrollableFrostedCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Post'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LandingPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }
}
