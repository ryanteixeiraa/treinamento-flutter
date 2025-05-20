import 'package:flutter/material.dart';
import 'package:treinamento/screens/login_screen.dart'; // Certifique-se de que a LoginScreen existe nesse diretório
import 'package:treinamento/screens/admin/admin_tutorials_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Administrativo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Redireciona para a tela de login ao clicar no botão de sair
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(), // Aqui chamando a LoginScreen
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bem-vindo ao Painel Administrativo!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gerencie os recursos do aplicativo abaixo:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Seção de tutoriais
            _buildAdminSection(
              context,
              'Gerenciar Tutoriais',
              'Adicione, edite ou exclua tutoriais interativos.',
              Icons.library_books,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageTutorialsScreen()),
                );
              },
            ),

            // Mais seções podem ser adicionadas conforme necessário
          ],
        ),
      ),
    );
  }

  // Widget para construir uma seção do painel de administração
  Widget _buildAdminSection(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
