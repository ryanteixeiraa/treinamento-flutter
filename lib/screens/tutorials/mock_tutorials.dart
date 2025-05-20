import 'package:flutter/material.dart';
import 'package:treinamento/models/tutorial_model.dart';

List<TutorialModel> mockTutorials = [
  TutorialModel(
    id: '1',
    icone: Icons.lightbulb,
    titulo: 'Primeiro Tutorial',
    subtitulo: 'Introdução ao aplicativo',
  ),
  TutorialModel(
    id: '2',
    titulo: 'Máquinas Pesadas',
    subtitulo: 'Operação segura de máquinas',
    icone: Icons.construction,
  ),
  TutorialModel(
    id: '3',
    titulo: 'Introdução',
    subtitulo: 'Como começar',
    icone: Icons.school,
  ),
];
