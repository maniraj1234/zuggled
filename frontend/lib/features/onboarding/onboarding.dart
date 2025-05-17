import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

///**Onboarding Screen**
///
/// This is then first screen that users see when they open the app.
/// Provides a series of onboarding pages that introduce the app's features.
/// Presents swipable [pageView] pages

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// A list of onboarding content, each containing an image path, title, and subtitle.
  List<Map<String, String>> _onboardingData = [];

  /// Controls the onboarding [PageView] to by switch pages.
  final PageController _pageController = PageController();

  /// Tracks the currently visible onboarding page.
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadOnboardingItems();
  }

  /// Loads onboarding data from a JSON file located in `lib/assets/json/`.
  ///
  /// Each item in the JSON is expected to have `image`, `title`, and `subtitle` keys.
  /// updates the state with the loaded data.
  Future<void> _loadOnboardingItems() async {
    final String jsonString = await rootBundle.loadString(
      'lib/assets/json/onboarding_data.json',
    );
    //convert the json string to a list of maps
    final List<dynamic> jsonList = json.decode(jsonString);
    setState(() {
      _onboardingData =
          jsonList
              .map<Map<String, String>>(
                (item) => {
                  "image": item['image'] ?? '',
                  "title": item['title'] ?? '',
                  "subtitle": item['subtitle'] ?? '',
                },
              )
              .toList();
    });
  }

  /// Navigates to the next onboarding page, or to login if on the last page.
  void _nextPage() {
    //navigates to next page if current page is not the last page
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    //if Current Page is last page then navigate to login page.
    else {
      context.go('/login');
    }
  }

  ///Builds a dot indicator for the current onboarding page.
  ///
  ///returns [AnimatedContainer] which serves as a page indicator (dot)
  ///
  /// The [isActive] parameter determines whether the dot is currently selected:
  /// - If `true`, the dot appears larger and in pink.
  /// - If `false`, the dot appears smaller and grey.
  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.pinkAccent : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: (index) {
                //updates the current page index
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                //current onboarding screen data
                final data = _onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(data['image']!, height: 300),
                      const SizedBox(height: 40),
                      Text(
                        data['title']!,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data['subtitle']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //generates a row of dot indicator progress for page view
            children: List.generate(
              _onboardingData.length,
              (index) => _buildIndicator(index == _currentPage),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                //Change the text from GetStarted to Next on the last PageView
                child: Text(
                  _currentPage == _onboardingData.length - 1
                      ? 'Get Started'
                      : 'Next',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
