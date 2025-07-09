![TreinaLab](https://github.com/user-attachments/assets/4b6b1a2a-9835-434a-bc09-29846ef88e9d)




📱 Bem-vindo ao TreinaLab
Aplicativo móvel desenvolvido em Flutter com foco em capacitação de colaboradores e treinamentos técnicos. O TreinaLab oferece tutoriais interativos, gerenciamento de conteúdo e proposta futura de simulações com Realidade Aumentada (RA).

#TreinaLab #FlutterApp #RA #Capacitação

✨ Funcionalidades
✅ Cadastro e edição de tutoriais com título, subtítulo, ícone e modelo 3D (RA opcional)
📁 Armazenamento local em JSON persistente
📝 Interface administrativa para gerenciamento de conteúdo
📲 Visualização dos tutoriais pelo usuário final
🧠 Realidade Aumentada (proposta futura) com integração a modelos .glb

🚀 Tecnologias Utilizadas
Linguagem: Dart

Framework: Flutter

IDE: Android Studio Meerkat (2024.3.1 Patch 1)

Pacotes principais:

provider – gerenciamento de estado

shared_preferences – salvar preferências locais

google_fonts – fontes customizadas

sceneview_flutter – visualização 3D para RA (ainda em teste)

📦 Instalação
1. Clone o repositório:
   bash
   Copiar
   Editar
   git clone https://github.com/ryanteixeiraa/treinalab.git
2. Acesse a pasta do projeto:
   bash
   Copiar
   Editar
   cd treinalab
3. Instale as dependências:
   bash
   Copiar
   Editar
   flutter pub get
4. Execute o aplicativo:
   bash
   Copiar
   Editar
   flutter run
   🛠️ Requisitos
   ✅ Flutter SDK 3.32.2

✅ Dart SDK 3.8.1

✅ Android Studio (ou VS Code) com plugin Flutter

✅ Emulador Android ou dispositivo físico

✅ Min SDK: 28

📌 Status do Projeto
✅ Funcionalidades de CRUD de tutoriais finalizadas

✅ Salvamento local com JSON implementado

🚧 Realidade Aumentada (RA) em fase de testes (implementação pausada)

📂 Estrutura do Projeto
css
Copiar
Editar
lib/
├── models/
│   └── tutorial_model.dart
├── controllers/
│   └── tutorial_controller.dart
├── screens/
│   ├── admin/
│   │   ├── admin_tutorials_screen.dart
│   │   └── edit_tutorial_screen.dart
│   ├── tutorials/
│   │   └── tutorial_screen.dart
│   └── onboarding_screen.dart
├── widgets/
│   └── training_card.dart
└── main.dart



📬 Contato
Desenvolvedores: Ryan Teixeira e Victória Salles
📧 E-mail: [ryanccomp@gmmail.com] | [victoriatvgsalles@gmail.com]
🔗 GitHub: https://github.com/ryanteixeiraa
