import kotlin.text.toInt

// android/app/build.gradle.kts (Nível do Aplicativo)

plugins {
    id("com.android.application") // Versão é herdada do arquivo de nível de projeto
    id("kotlin-android")          // Versão é herdada do arquivo de nível de projeto
    id("dev.flutter.flutter-gradle-plugin") // Plugin do Flutter
}

val flutterVersionCode: String? by project
val flutterVersionName: String? by project

android {
    namespace = "com.example.treinamento"
    compileSdk = 33 // Recomendado: Usar a API mais recente estável

    defaultConfig {
        applicationId = "com.example.treinamento"
        minSdk = 24 // Necessário para ARCore
        targetSdk = 33 // Deve corresponder ou ser próximo ao compileSdk

        versionCode = flutterVersionCode?.toInt() ?: 1
        versionName = flutterVersionName ?: "1.0"
    }

    // ndkVersion é geralmente configurado pelo Flutter ou se você tiver código C++ específico.
    // Se não tiver certeza, pode ser gerenciado pelo AGP/Flutter.
    // ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        getByName("debug") {
            // Configurações de assinatura de debug são geralmente padrão.
            // Para release, você precisará de uma configuração adequada.
        }
    }

    buildTypes {
        getByName("release") {
            // TODO: Configure sua própria assinatura para builds de release.
            // Exemplo: signingConfig = signingConfigs.getByName("myReleaseConfig")
            signingConfig = signingConfigs.getByName("debug") // Temporário para `flutter run --release`

            // isMinifyEnabled = true // Habilite para otimizar e ofuscar o código de release
            // proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
        getByName("debug") {
            // Configurações específicas para debug, se necessário.
        }
    }

    // packagingOptions podem ser necessárias se houver conflitos de bibliotecas nativas (.so)
    // packagingOptions {
    //     pickFirsts += listOf(
    //         "lib/**/libarcore_sdk_c.so", // Usar wildcards pode ser mais genérico
    //         "lib/**/libarcore_sdk_jni.so"
    //     )
    //     resources.excludes.add("META-INF/**")
    // }
}

flutter {
    source = "../.." // Padrão para projetos Flutter
}

dependencies {
// O Flutter gerencia a dependência do Kotlin stdlib.
// Você não precisa declará-la aqui explicitamente na maioria dos casos.

// Adicione outras dependências Android nativas específicas do seu app aqui, se necessário.
// Exemplo:
// implementation("androidx.core:core-ktx:1.12.0")
// implementation("androidx.appcompat:appcompat:1.6.1")
// implementation("com.google.android.material:material:1.11.0")

// Dependências de AR são geralmente transitivas