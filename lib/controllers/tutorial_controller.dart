import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:treinamento/models/tutorial_model.dart'; // Ajuste o caminho se necessário

class TutorialController extends ChangeNotifier {
  List<TutorialModel> _tutoriais = [];
  bool _isLoading = true;
  static const String _fileName = 'tutoriais_persistidos.json'; // Nome do arquivo JSON

  List<TutorialModel> get tutorials => List.unmodifiable(_tutoriais);
  bool get isLoading => _isLoading;

  TutorialController() {
    _carregarTutoriaisDoArquivo();
  }

  // --- Lógica de Persistência (agora dentro do Controller) ---

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<void> _salvarTutoriaisNoArquivo() async {
    try {
      final file = await _localFile;
      final List<Map<String, dynamic>> jsonData =
      _tutoriais.map((tutorial) => tutorial.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonData));
      print("Controller: Tutoriais salvos com sucesso em: ${file.path}");
    } catch (e) {
      print("Controller: ERRO AO SALVAR TUTORIAIS: $e");
      // Considerar como lidar com o erro (talvez notificar a UI)
    }
  }

  Future<void> _carregarTutoriaisDoArquivo() async {
    _isLoading = true;
    notifyListeners(); // Notifica que o carregamento começou

    try {
      final file = await _localFile;
      if (!await file.exists()) { // Corrigido aqui também, usar await
        _tutoriais = [];
        print("Controller: Arquivo de tutoriais não encontrado. Iniciando com lista vazia.");
      } else {
        final contents = await file.readAsString();
        if (contents.isEmpty) {
          _tutoriais = [];
          print("Controller: Arquivo de tutoriais vazio. Iniciando com lista vazia.");
        } else {
          final List<dynamic> jsonData = jsonDecode(contents);
          _tutoriais = jsonData.map((item) => TutorialModel.fromJson(item)).toList();
          print("Controller: Tutoriais carregados com sucesso: ${_tutoriais.length} itens.");
        }
      }
    } catch (e) {
      print("Controller: Erro ao carregar tutoriais do arquivo: $e");
      _tutoriais = []; // Em caso de erro, começa com lista vazia para evitar crash
    }

    _isLoading = false;
    notifyListeners(); // Notifica que o carregamento terminou
  }

  // --- Métodos CRUD para manipular os tutoriais ---

  Future<void> addTutorial(TutorialModel tutorial) async {
    // Adiciona à lista em memória
    // Para melhor imutabilidade e para garantir que o Provider detecte a mudança
    // quando a referência da lista muda:
    _tutoriais = List<TutorialModel>.from(_tutoriais)..add(tutorial);

    notifyListeners(); // Notifica a UI imediatamente
    await _salvarTutoriaisNoArquivo(); // Salva no arquivo
  }

  Future<void> updateTutorial(TutorialModel updatedTutorial) async {
    final index = _tutoriais.indexWhere((t) => t.id == updatedTutorial.id);
    if (index != -1) {
      // Cria uma nova lista para imutabilidade
      _tutoriais = List<TutorialModel>.from(_tutoriais);
      _tutoriais[index] = updatedTutorial;
      notifyListeners();
      await _salvarTutoriaisNoArquivo();
    }
  }

  Future<void> removeTutorial(String id) async {
    // Cria uma nova lista para imutabilidade
    _tutoriais = List<TutorialModel>.from(_tutoriais)..removeWhere((t) => t.id == id);
    notifyListeners();
    await _salvarTutoriaisNoArquivo();
  }

  // Método de exemplo para sua tela AddTutorialScreen chamar
  // Você passaria os dados do formulário para este método
  void adicionarNovoTutorialDaTela(String titulo, String subtitulo, IconData icone) {
    final novoId = DateTime.now().millisecondsSinceEpoch.toString(); // ID único simples
    final novoTutorial = TutorialModel(
      id: novoId,
      icone: icone,
      titulo: titulo,
      subtitulo: subtitulo,
    );
    addTutorial(novoTutorial);
  }

  // Para exportar/debug
  // CORREÇÃO AQUI:
  Future<File?> getArquivoJson() async {
    final file = await _localFile;
    if (await file.exists()) { // Adicionado await aqui
      return file;
    } else {
      return null;
    }
  }
}