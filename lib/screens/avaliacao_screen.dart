import 'package:flutter/material.dart';

class AvaliacaoScreen extends StatelessWidget {
  const AvaliacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações de Desempenho'),
      ),
      body: Center(
        child: Text(
          'Aqui ficarão as avaliações de desempenho!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
