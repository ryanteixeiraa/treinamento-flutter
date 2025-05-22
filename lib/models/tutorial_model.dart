import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// Se for usar o share_plus para exportar:
// import 'package:share_plus/share_plus.dart';

// --- Seu TutorialModel (deixe como está) ---
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

// --- Seu TutorialManager (deixe como está) ---
class TutorialManager {
  static const String _fileName = 'tutoriais.json';
  List<TutorialModel> _tutoriais = [];

  List<TutorialModel> get tutoriais => _tutoriais;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<void> carregarTutoriais() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        _tutoriais = [];
        return;
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);
      _tutoriais = jsonData.map((item) => TutorialModel.fromJson(item)).toList();
    } catch (e) {
      print("Erro ao carregar tutoriais: $e");
      _tutoriais = [];
    }
  }

  Future<File> salvarTutoriais() async {
    final file = await _localFile;
    final List<Map<String, dynamic>> jsonData =
    _tutoriais.map((tutorial) => tutorial.toJson()).toList();
    return file.writeAsString(jsonEncode(jsonData));
  }

  Future<void> adicionarTutorial(TutorialModel tutorial) async {
    _tutoriais.add(tutorial);
    await salvarTutoriais();
  }

  Future<File?> obterArquivoJsonParaExportar() async {
    if (_tutoriais.isEmpty) {
      print("Nenhum tutorial para exportar.");
      return null;
    }
    try {
      final path = await _localPath;
      final file = File('$path/$_fileName');
      await salvarTutoriais(); // Garante que o arquivo está atualizado
      if (await file.exists()) {
        return file;
      }
    } catch (e) {
      print("Erro ao obter arquivo para exportar: $e");
    }
    return null;
  }
}

// --- Widget da Tela de Tutoriais (Corrigido e Completo) ---
class MinhaTelaDeTutoriais extends StatefulWidget {
  @override
  _MinhaTelaDeTutoriaisState createState() => _MinhaTelaDeTutoriaisState();
}

class _MinhaTelaDeTutoriaisState extends State<MinhaTelaDeTutoriais> {
  final TutorialManager _tutorialManager = TutorialManager();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() { // Atualiza para mostrar o loading se necessário
      _isLoading = true;
    });
    await _tutorialManager.carregarTutoriais();
    setState(() {
      _isLoading = false;
    });
  }

  void _adicionarNovoTutorial() {
    final novoTutorial = TutorialModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      icone: Icons.add_circle_outline,
      titulo: "Novo Tutorial ${(_tutorialManager.tutoriais.length + 1)}",
      subtitulo: "Este é um novo tutorial adicionado.",
    );

    // Adiciona na UI imediatamente e depois salva
    setState(() {
      _tutorialManager.tutoriais.add(novoTutorial); // Adiciona na lista local para UI imediata
    });

    _tutorialManager.adicionarTutorial(novoTutorial).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tutorial salvo com sucesso!')),
      );
    }).catchError((error) {
      // Em caso de erro ao salvar, pode ser útil remover o tutorial da UI
      // ou mostrar uma mensagem de erro específica.
      setState(() {
        _tutorialManager.tutoriais.remove(novoTutorial);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar tutorial: $error')),
      );
    });
  }

  void _exportarTutoriais() async {
    final arquivo = await _tutorialManager.obterArquivoJsonParaExportar();
    if (arquivo != null) {
      // Aqui você pode usar um pacote como share_plus para compartilhar o arquivo
      // Exemplo com share_plus (precisa adicionar a dependência e importar)
      // await Share.shareFiles([arquivo.path], text: 'Aqui estão os seus tutoriais!');

      // Ou, se quiser apenas mostrar o caminho (para debug):
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Arquivo JSON gerado em: ${arquivo.path}')),
      );
      print('Arquivo JSON para exportar em: ${arquivo.path}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhum tutorial para exportar ou erro ao gerar o arquivo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Tutoriais'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportarTutoriais,
            tooltip: 'Exportar JSON',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _tutorialManager.tutoriais.isEmpty
          ? Center(child: Text('Nenhum tutorial adicionado ainda.'))
          : ListView.builder(
        itemCount: _tutorialManager.tutoriais.length,
        itemBuilder: (context, index) {
          final tutorial = _tutorialManager.tutoriais[index];
          return ListTile(
            leading: Icon(tutorial.icone),
            title: Text(tutorial.titulo),
            subtitle: Text(tutorial.subtitulo),
            // Você pode adicionar um trailing para opções como deletar
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarNovoTutorial,
        tooltip: 'Adicionar Tutorial',
        child: Icon(Icons.add),
      ),
    );
  }
}

