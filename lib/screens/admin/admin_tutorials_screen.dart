import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treinamento/controllers/tutorial_controller.dart';
import 'package:treinamento/screens/admin/edit_tutorial_screen.dart';

class ManageTutorialsScreen extends StatelessWidget {
  const ManageTutorialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tutorials = context.watch<TutorialController>().tutorials;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Tutoriais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditTutorialScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: tutorials.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nenhum tutorial cadastrado.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditTutorialScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Tutorial'),
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tutorials.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final tutorial = tutorials[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                tutorial.icone,
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                tutorial.titulo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tutorial.subtitulo),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'editar') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditTutorialScreen(tutorial: tutorial),
                      ),
                    );
                  } else if (value == 'excluir') {
                    context.read<TutorialController>().removeTutorial(tutorial.id);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'editar', child: Text('Editar')),
                  PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
