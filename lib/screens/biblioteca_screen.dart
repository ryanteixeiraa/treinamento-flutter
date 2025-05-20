import 'package:flutter/material.dart';

class BibliotecaScreen extends StatelessWidget {
  const BibliotecaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca de Recursos'),
      ),
      body: Center(
        child: Text(
          'Aqui ficarão os materiais complementares, como vídeos e documentos!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
