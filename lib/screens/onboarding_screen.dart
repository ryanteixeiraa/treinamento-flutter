import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treinamento/theme/app_colors.dart';
import 'package:treinamento/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool _dontShowAgain = false;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Bem-vindo ao App de Treinamento!',
      'subtitle': 'Aprenda com simulações em realidade aumentada.',
      'icon': Icons.vrpano,
    },
    {
      'title': 'Tutoriais Interativos',
      'subtitle': 'Siga instruções passo a passo com recursos visuais.',
      'icon': Icons.school,
    },
    {
      'title': 'Avalie e Certifique',
      'subtitle': 'Teste seus conhecimentos e receba certificados.',
      'icon': Icons.verified,
    },
  ];

  void _nextPage() async {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (_dontShowAgain) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('onboarding_seen', true);
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          page['icon'],
                          size: 100,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          page['title'],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          page['subtitle'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87, // contraste reforçado
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (index == _pages.length - 1) ...[
                          const SizedBox(height: 30),
                          Flexible(
                            child: CheckboxListTile(
                              value: _dontShowAgain,
                              onChanged: (value) {
                                setState(() {
                                  _dontShowAgain = value ?? false;
                                });
                              },
                              title: const Text('Não mostrar novamente'),
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _pages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 12 : 8,
                        height: _currentPage == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      if (_currentPage > 0)
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: _previousPage,
                        ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Começar'
                              : 'Próximo',
                          style: const TextStyle(fontSize: 16),
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
    );
  }
}
