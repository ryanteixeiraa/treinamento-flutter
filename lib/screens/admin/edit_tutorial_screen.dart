import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treinamento/models/tutorial_model.dart';
import 'package:treinamento/controllers/tutorial_controller.dart';

class EditTutorialScreen extends StatefulWidget {
  final TutorialModel? tutorial;

  const EditTutorialScreen({super.key, this.tutorial});

  @override
  State<EditTutorialScreen> createState() => _EditTutorialScreenState();
}

class _EditTutorialScreenState extends State<EditTutorialScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _subtituloController;
  IconData? _iconeSelecionado;

  final List<IconData> _iconesDisponiveis = [
    Icons.health_and_safety,
    Icons.construction,
    Icons.school,
    Icons.engineering,
  ];

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tutorial?.titulo ?? '');
    _subtituloController = TextEditingController(text: widget.tutorial?.subtitulo ?? '');
    _iconeSelecionado = widget.tutorial?.icone;
  }

  void _salvarEdicao() {
    if (_tituloController.text.isEmpty ||
        _subtituloController.text.isEmpty ||
        _iconeSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos.')),
      );
      return;
    }

    final tutorialController = context.read<TutorialController>();

    if (widget.tutorial == null) {
      // Criando novo tutorial
      final novoTutorial = TutorialModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // ou use um UUID
        titulo: _tituloController.text,
        subtitulo: _subtituloController.text,
        icone: _iconeSelecionado!,
      );
      tutorialController.addTutorial(novoTutorial);
    } else {
      // Editando tutorial existente
      final atualizado = TutorialModel(
        id: widget.tutorial!.id,
        titulo: _tituloController.text,
        subtitulo: _subtituloController.text,
        icone: _iconeSelecionado!,
      );
      tutorialController.updateTutorial(atualizado);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.tutorial != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Tutorial' : 'Novo Tutorial')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _subtituloController,
              decoration: const InputDecoration(labelText: 'Subtítulo'),
            ),
            const SizedBox(height: 24),
            const Text('Ícone', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _iconesDisponiveis.map((icone) {
                final isSelected = _iconeSelecionado == icone;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _iconeSelecionado = icone;
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: isSelected
                          ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
                          : BorderSide.none,
                    ),
                    elevation: isSelected ? 4 : 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        icone,
                        size: 36,
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _salvarEdicao,
                child: Text(isEditing ? 'Salvar Alterações' : 'Cadastrar Tutorial'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
