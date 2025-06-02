import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart'; // Import necessário
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:treinamento/models/tutorial_model.dart';

class TutorialARViewScreen extends StatefulWidget {
  final TutorialModel tutorial;

  const TutorialARViewScreen({Key? key, required this.tutorial}) : super(key: key);

  @override
  _TutorialARViewScreenState createState() => _TutorialARViewScreenState();
}

class _TutorialARViewScreenState extends State<TutorialARViewScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  ARNode? _currentModelNodeConfig;
  ARNode? _addedNode; // Referência ao nó que foi efetivamente adicionado

  String _statusMessage = "Carregando AR...";

  @override
  void dispose() {
    try {
      // É muito importante chamar dispose para liberar recursos nativos
      if (arObjectManager != null) arObjectManager.dispose();
      if (arSessionManager != null) arSessionManager.dispose();
    } catch (e) {
      print("Erro ao dispor dos AR managers: $e");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR: ${widget.tutorial.titulo}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ARView(
              onARViewCreated: onARViewCreated,
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: null, // "assets/models/triangle.png"
      showWorldOrigin: false,
      handleTaps: true,
    );
    this.arObjectManager.onInitialize();

    this.arSessionManager.onPlaneOrPointTap = _onPlaneOrPointTapped;

    if (widget.tutorial.nomeModelo3D != null && widget.tutorial.nomeModelo3D!.isNotEmpty) {
      // Certifique-se que o caminho está correto, ex: "models/meu_modelo.glb"
      // Se seu arquivo está em assets/models/meu_modelo.glb, use "models/meu_modelo.glb"
      _prepareModel(widget.tutorial.nomeModelo3D!);
      setState(() {
        _statusMessage = "Modelo ${widget.tutorial.nomeModelo3D} preparado. Toque em um plano detectado.";
      });
    } else {
      print("Nenhum nome de modelo 3D fornecido para este tutorial.");
      setState(() {
        _statusMessage = "Este tutorial não possui um modelo 3D associado.";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Este tutorial não possui um modelo 3D associado.')),
      );
    }
  }

  void _prepareModel(String modelAssetPath) {
    _currentModelNodeConfig = ARNode(
      type: NodeType.localGLB,
      uri: modelAssetPath, // Ex: "models/meu_modelo.glb"
      scale: vector.Vector3(0.3, 0.3, 0.3),
      position: vector.Vector3(0.0, 0.0, 0.0),
      rotation: vector.Vector4(0.0, 0.0, 0.0, 1.0),
    );
    print("Modelo $modelAssetPath preparado.");
  }

  Future<void> _onPlaneOrPointTapped(List<ARHitTestResult> hitTestResults) async {
    if (_currentModelNodeConfig == null) {
      print("Configuração do modelo não está pronta.");
      setState(() {
        _statusMessage = "Modelo não configurado. Verifique os logs.";
      });
      return;
    }

    ARHitTestResult? planeHitResult;
    // Encontra o primeiro resultado de hit em um plano
    for (var hit in hitTestResults) {
      if (hit.type == ARHitTestResultType.plane) {
        planeHitResult = hit;
        break;
      }
    }

    if (planeHitResult != null) {
      if (_addedNode != null) {
        await arObjectManager.removeNode(_addedNode!);
        _addedNode = null;
        print("Nó anterior removido.");
      }

      ARNode nodeToPlace = ARNode(
          type: _currentModelNodeConfig!.type,
          uri: _currentModelNodeConfig!.uri,
          scale: _currentModelNodeConfig!.scale,
          transformation: planeHitResult.worldTransform);

      bool? didAddSuccessfully = await arObjectManager.addNode(nodeToPlace);

      if (didAddSuccessfully == true) { // Verificação explícita de true
        _addedNode = nodeToPlace;
        print("Modelo adicionado/movido para a posição do toque no plano.");
        setState(() {
          _statusMessage = "Modelo posicionado! Explore ao redor.";
        });
      } else {
        print("Falha ao adicionar o nó na cena.");
        setState(() {
          _statusMessage = "Falha ao posicionar o modelo. Tente novamente.";
        });
      }
    } else {
      print("Nenhum plano detectado no ponto de toque.");
      setState(() {
        _statusMessage = "Nenhum plano detectado. Tente em uma superfície bem iluminada e texturizada.";
      });
    }
  }
}