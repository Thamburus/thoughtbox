import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughtbox/pages/loginpage.dart';
void main() {
  runApp(MaterialApp(
    home: OnboardingScreen(),
  ));
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            _buildPage(
              'Welcome to Thought Box',
              '',
              Icons.arrow_forward,
            ),
            _buildPage(
              'Get started!',
              '',
              Icons.check,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            IconButton(
              icon: _currentPage == 1
                  ? Icon(Icons.done)
                  : Icon(Icons.arrow_forward),
              onPressed: () {
                if (_currentPage == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, String subtitle, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 120.0),
        SizedBox(height: 32.0),
        Text(title, style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(subtitle, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}




