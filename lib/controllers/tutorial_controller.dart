import 'package:flutter/material.dart';
import 'package:treinamento/models/tutorial_model.dart';

class TutorialController extends ChangeNotifier {
  final List<TutorialModel> _tutorials = [
    TutorialModel(
      id: '1',
      titulo: 'Tutorial de Segurança',
      subtitulo: 'Aprenda normas de segurança no trabalho',
      icone: Icons.health_and_safety,
    ),
    TutorialModel(
      id: '2',
      titulo: 'Treinamento Técnico',
      subtitulo: 'Capacitação para operação de máquinas',
      icone: Icons.engineering,
    ),
  ];

  // ✅ Getter para acessar os tutoriais
  List<TutorialModel> get tutorials => List.unmodifiable(_tutorials);

  // ✅ Adiciona um tutorial novo
  void addTutorial(TutorialModel tutorial) {
    _tutorials.add(tutorial);
    notifyListeners();
  }

  // ✅ Atualiza tutorial existente
  void updateTutorial(TutorialModel updated) {
    final index = _tutorials.indexWhere((t) => t.id == updated.id);
    if (index != -1) {
      _tutorials[index] = updated;
      notifyListeners();
    }
  }

  // ✅ Remove tutorial por ID
  void removeTutorial(String id) {
    _tutorials.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}
