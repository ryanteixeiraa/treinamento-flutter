import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/training_card.dart';
import 'package:treinamento/controllers/tutorial_controller.dart';
import 'package:treinamento/screens/admin/add_tutorial_screen.dart'; // Para navegar

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
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTutorialScreen()),
                );
              },
            ),
          ],
        ),
        body: tutorialController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : tutorialController.tutorials.isEmpty
            ? const Center(
          child: Text('Nenhum tutorial disponível. Adicione um!'),
        )
            : ListView.builder(
        padding: const EdgeInsets.all(16),
    itemCount: tutorialController.tutorials.length,
    itemBuilder: (context, index) {
    final tutorial = tutorialController.tutorials[index];
    return TrainingCard( // Seu widget TrainingCard
    title: tutorial.titulo,
    subtitle: tutorial.subtitulo,
    icon: tutorial.icone,
    onTap: () {
    // Ação ao tocar, talvez navegar para EditTutorialScreen
    // ou uma tela de visualização do tutorial
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Abrindo tutorial: ${tutorial.titulo}...')),
              );
            },
          );
        },
      ),
    );
  }
}
