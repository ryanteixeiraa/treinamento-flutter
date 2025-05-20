import 'package:flutter/material.dart';

class TutorialModel {
  final String id;
  final IconData icone;
  final String titulo;
  final String subtitulo;

  TutorialModel({
    required this.id,
    required this.icone,
    required this.titulo,
    required this.subtitulo,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'icone': icone.codePoint,
    'titulo': titulo,
    'subtitulo': subtitulo,
  };

  factory TutorialModel.fromJson(Map<String, dynamic> json) {
    return TutorialModel(
      id: json['id'],
      icone: IconData(json['icone'], fontFamily: 'MaterialIcons'),
      titulo: json['titulo'],
      subtitulo: json['subtitulo'],
    );
  }
}
