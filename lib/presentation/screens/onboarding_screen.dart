import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your onboarding pages with icons.
    final pages = [
      Container(
        color: Colors.blueAccent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.gem, color: Colors.white, size: 80),
                const SizedBox(height: 24),
                Text(
                  'Welcome to KGK Diamond Selection',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        color: Colors.deepPurple,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.filter, color: Colors.white, size: 80),
                const SizedBox(height: 24),
                Text(
                  'Filter, sort and view diamonds with ease',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        color: Colors.teal,
        child: GestureDetector(
          onTap: () {
            // Navigate to the FilterPage (main app flow).
            // For example, using GoRouter:
            context.go('/');
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.shoppingCart,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Add your favorites to the cart and manage your selections effortlessly.\n\nTap anywhere to get started.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: false,
        fullTransitionValue: 600.0,
        slideIconWidget: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ), // Optional swipe icon.
        positionSlideIcon: 0.5,
        onPageChangeCallback: (index) {
          // Optionally perform actions when the page changes.
        },
      ),
    );
  }
}
