import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treinamento/controllers/tutorial_controller.dart';
import 'package:treinamento/models/tutorial_model.dart';
import 'package:treinamento/screens/tutorials/tutorial_ar_view_screen.dart';
import 'package:treinamento/screens/admin/add_tutorial_screen.dart';

// Definição do TrainingCard (caso ainda não esteja separado em outro arquivo)
class TrainingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const TrainingCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorialController = context.watch<TutorialController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutoriais Interativos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTutorialScreen()),
              );
            },
          ),
        ],
      ),
      body: tutorialController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : tutorialController.tutorials.isEmpty
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Nenhum tutorial disponível no momento. Adicione um novo tutorial para começar!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: tutorialController.tutorials.length,
        itemBuilder: (context, index) {
          final tutorial = tutorialController.tutorials[index];
          return TrainingCard(
            title: tutorial.titulo,
            subtitle: tutorial.subtitulo,
            icon: tutorial.icone,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TutorialARViewScreen(tutorial: tutorial),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
