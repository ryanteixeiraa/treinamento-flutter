import 'package:flutter/material.dart';
import 'package:treinamento/models/tutorial_model.dart';

class AddTutorialScreen extends StatefulWidget {
  const AddTutorialScreen({super.key});

  @override
  State<AddTutorialScreen> createState() => _AddTutorialScreenState();
}

class _AddTutorialScreenState extends State<AddTutorialScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _subtituloController = TextEditingController();
  IconData? _iconeSelecionado;

  final List<IconData> _iconesDisponiveis = [
    Icons.health_and_safety,
    Icons.construction,
    Icons.school,
    Icons.engineering,
  ];

  void _salvarTutorial() {
    if (_tituloController.text.isNotEmpty &&
        _subtituloController.text.isNotEmpty &&
        _iconeSelecionado != null) {
      final novoTutorial = TutorialModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titulo: _tituloController.text,
        subtitulo: _subtituloController.text,
        icone: _iconeSelecionado!,
      );
      Navigator.pop(context, novoTutorial);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Tutorial')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _subtituloController,
              decoration: const InputDecoration(labelText: 'Subtítulo'),
            ),
            const SizedBox(height: 16),
            const Text('Ícone'),
            Wrap(
              spacing: 12,
              children: _iconesDisponiveis.map((icone) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _iconeSelecionado = icone;
                    });
                  },
                  child: Icon(
                    icone,
                    size: 36,
                    color: _iconeSelecionado == icone
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarTutorial,
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
