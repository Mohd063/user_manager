import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:manage_me/core/constants/colors.dart';
import 'package:manage_me/presentation/screens/user/user_list_screen.dart';
import 'no_internet_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  String? title;
  String? subtitle;
  String? logoPath;

  late AnimationController _dotsController;
  int _currentDot = 0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for page indicator
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _checkInternetAndFetchData();
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  Future<void> _checkInternetAndFetchData() async {
    setState(() => _isLoading = true);

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NoInternetScreen(
              onRetry: () {
                Navigator.pop(context);
                _checkInternetAndFetchData();
              },
            ),
          ),
        );
      }
      setState(() => _isLoading = false);
      return;
    }

    _fetchOnboardingData();
  }

  Future<void> _fetchOnboardingData() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulated network call

      final data = {
        'title': 'ManageMe',
        'subtitle': 'Managing Users Made Simple',
        'logoPath': 'assets/images/Logo.png',
      };

      setState(() {
        title = data['title'];
        subtitle = data['subtitle'];
        logoPath = data['logoPath'];
        _isLoading = false;
        _hasError = false;
      });

      // Auto navigate to next screen after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const UserListScreen()),
          );
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _isLoading
                ? const CircularProgressIndicator()
                : _hasError
                    ? _buildErrorUI()
                    : _buildContentUI(),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 64),
        const SizedBox(height: 16),
        Text(
          'Failed to load data',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _errorMessage ?? 'Unknown error occurred',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textGray,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
              _hasError = false;
              _errorMessage = null;
            });
            _checkInternetAndFetchData();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }

  Widget _buildContentUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          logoPath ?? 'assets/images/Logo.png',
          height: 100,
        ),
        const SizedBox(height: 32),
        Text(
          title ?? "ManageMe",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle ?? "Managing Users Made Simple",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textGray,
          ),
        ),
        const SizedBox(height: 40),

        // Animated Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            bool isActive = index == _currentDot;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 16 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.indicatorActive
                    : AppColors.indicatorInactive,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        ),
      ],
    );
  }
}
