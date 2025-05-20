import 'package:flutter/material.dart';
import 'package:treinamento/screens/simulacao_screen.dart';
import 'package:treinamento/screens/tutorial_screen.dart';
import 'package:treinamento/screens/avaliacao_screen.dart';
import 'package:treinamento/screens/biblioteca_screen.dart';
import 'package:treinamento/screens/certificacao_screen.dart';
import 'package:treinamento/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    SimulacaoScreen(),
    TutorialScreen(),
    AvaliacaoScreen(),
    BibliotecaScreen(),
    CertificacaoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<String> _titles = [
    'Simulações',
    'Tutoriais',
    'Avaliações',
    'Biblioteca',
    'Certificação',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Voltar à tela inicial',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_in_ar),
            label: 'Simulação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Tutoriais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Avaliações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified),
            label: 'Certificação',
          ),
        ],
      ),
    );
  }
}
