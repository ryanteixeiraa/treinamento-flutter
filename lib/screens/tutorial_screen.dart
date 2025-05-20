import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/training_card.dart';
import 'package:treinamento/controllers/tutorial_controller.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorials = context.watch<TutorialController>().tutorials;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutoriais Interativos'),
      ),
      body: tutorials.isEmpty
          ? const Center(
        child: Text('Nenhum tutorial disponível.'),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tutorials.length,
        itemBuilder: (context, index) {
          final tutorial = tutorials[index];
          return TrainingCard(
            title: tutorial.titulo,
            subtitle: tutorial.subtitulo,
            icon: tutorial.icone,
            onTap: () {
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
