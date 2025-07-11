import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/routing/app_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to Fairy Tales!',
      description: 'Create magical stories with AI, voice narration, and enchanting animations.',
      imagePath: 'assets/animations/welcome_fairy.json',
      backgroundColor: Colors.purple.shade50,
    ),
    OnboardingPage(
      title: 'Create Your Stories',
      description: 'Use AI to generate stories, characters, and magical worlds. Your imagination is the limit!',
      imagePath: 'assets/animations/story_creation.json',
      backgroundColor: Colors.pink.shade50,
    ),
    OnboardingPage(
      title: 'Interactive Adventures',
      description: 'Make choices that change the story. Discover secret paths and multiple endings!',
      imagePath: 'assets/animations/adventure_path.json',
      backgroundColor: Colors.blue.shade50,
    ),
    OnboardingPage(
      title: 'Voice & Animation',
      description: 'Listen to AI narration and watch beautiful animations bring your stories to life.',
      imagePath: 'assets/animations/magic_voice.json',
      backgroundColor: Colors.green.shade50,
    ),
    OnboardingPage(
      title: 'Share the Magic',
      description: 'Share your stories with friends and family. Discover amazing tales from other creators!',
      imagePath: 'assets/animations/sharing_magic.json',
      backgroundColor: Colors.orange.shade50,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    // Show options: Login, Sign Up, or Continue as Guest
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const _GetStartedBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _pages[_currentPage].backgroundColor,
                  _pages[_currentPage].backgroundColor.withOpacity(0.7),
                  Colors.white,
                ],
              ),
            ),
          ),
          
          // Floating particles animation
          ...List.generate(8, (index) => 
            Positioned(
              left: (index * 50.0) % MediaQuery.of(context).size.width,
              top: (index * 80.0) % MediaQuery.of(context).size.height,
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              )
                .animate(onPlay: (controller) => controller.repeat())
                .moveY(
                  begin: 0,
                  end: 20,
                  duration: Duration(milliseconds: 2000 + (index * 200)),
                  curve: Curves.easeInOut,
                )
                .then()
                .moveY(
                  begin: 20,
                  end: 0,
                  duration: Duration(milliseconds: 2000 + (index * 200)),
                  curve: Curves.easeInOut,
                ),
            ),
          ),
          
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                
                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return _OnboardingPageWidget(
                        page: _pages[index],
                        isActive: index == _currentPage,
                      );
                    },
                  ),
                ),
                
                // Bottom controls
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Page indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Navigation buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Previous button
                          if (_currentPage > 0)
                            OutlinedButton(
                              onPressed: _previousPage,
                              child: const Text('Previous'),
                            )
                          else
                            const SizedBox(width: 80),
                          
                          // Next/Get Started button
                          ElevatedButton(
                            onPressed: _nextPage,
                            child: Text(
                              _currentPage == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
  final bool isActive;

  const _OnboardingPageWidget({
    required this.page,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animation
          Container(
            height: 300,
            child: Lottie.asset(
              page.imagePath,
              height: 300,
              repeat: isActive,
              animate: isActive,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to a simple icon if animation fails to load
                return Icon(
                  Icons.auto_stories,
                  size: 150,
                  color: Theme.of(context).primaryColor,
                );
              },
            ),
          )
            .animate(target: isActive ? 1 : 0)
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.0, 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: const Duration(milliseconds: 400)),
          
          const SizedBox(height: 40),
          
          // Title
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          )
            .animate(target: isActive ? 1 : 0)
            .slideY(
              begin: 0.5,
              end: 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
            )
            .fadeIn(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 200),
            ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          )
            .animate(target: isActive ? 1 : 0)
            .slideY(
              begin: 0.5,
              end: 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
            )
            .fadeIn(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 400),
            ),
        ],
      ),
    );
  }
}

class _GetStartedBottomSheet extends ConsumerWidget {
  const _GetStartedBottomSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Title
          Text(
            'Ready to Begin?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'Choose how you\'d like to get started with Fairy Tales',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 32),
          
          // Options
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pushNamed('signup');
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Create Account'),
                ),
              ),
              
              const SizedBox(height: 12),
              
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pushNamed('login');
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Sign In'),
                ),
              ),
              
              const SizedBox(height: 12),
              
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    try {
                      await ref.read(authProvider.notifier).signInAnonymously();
                      if (context.mounted) {
                        context.go('/home');
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to continue as guest: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.explore),
                  label: const Text('Continue as Guest'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });
}