import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images-platform.99static.com/QaJZniGXtK44vAT6nYiN3NMNWD4=/146x111:1346x1311/500x500/top/smart/99designs-contests-attachments/94/94573/attachment_94573795',
                placeholder: (context, url) =>
                    CircularProgressIndicator(), // Placeholder widget while loading
                errorWidget: (context, url, error) =>
                    Icon(Icons.error), // Widget to display when there's an error
                width: 250,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // Arrow icon color white
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // Space below the button
          ],
        ),
      ),
    );
  }
}
